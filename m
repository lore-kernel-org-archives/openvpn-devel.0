Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B728B606A32D
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jw3xFJaN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nCBtPTtH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dDepAvb7;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=M4jrkxV5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=E40FNAdOqkLuVku7m2ET9tcwaY+vm7SuqSZGOFygxL0=; b=jw3xFJaNuAIipicUO4VXQIe3Nt
	XLVFZxwhWiURQogeEycD2+xHlwkKG7V0N1ZjrujBcoOGc0ZKO/X0QsJbZDjbcCoGOQ6muYV5fl9pw
	0kqRTo6bQNLQOoMVY4bKK7rtw6AW+8O7gusJn3XiG0xEph4Kn8kc2FrQ9YQyNxZv7ttE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWvrp-0000000011p-2HDB;
	Fri, 27 Nov 2026 13:19:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWvro-0000000011f-3BZW
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 13:19:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MF2Q1V/EtvKZoMEi+nOXp1ZGTmXe2V1X569j2rje/mw=; b=nCBtPTtHIENn4tam5oU2b+CzXu
 6CdHAFbGY4nh8KzH6P/b2z6e65oTsZVsPZhQbAnFoL0o32va57B+pQErtRFtV4hVX+imtRlu8441I
 m0F+AiKdtb9pczkZni1egUp19DckGeHZNhViu9ufmN8fK1Vf324zmh+BAbb42pqkj8A4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MF2Q1V/EtvKZoMEi+nOXp1ZGTmXe2V1X569j2rje/mw=; b=dDepAvb7lsRhx+9VNu6rDB9k92
 qVanvTgkPvG/OBkvWw5QuWzALR1+M/Uy0o1wqmU+NxBvk+iVrt0VHTz7h3/n701Avf2cvIONaPMej
 C5k3PM3s8//lcl97XrLUGaOSxBJxCOzLKRuaoQC1Od1mok+d7la0YOg1pRF1BCh+ABdk=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWvrm-000000004cd-4Ajw for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 13:19:56 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so55254105e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 05:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795785588; x=1796390388; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MF2Q1V/EtvKZoMEi+nOXp1ZGTmXe2V1X569j2rje/mw=;
 b=M4jrkxV5K4OCC5I4iDr5Dz4uJLv//VE7g24jxUKEp49lxQwD/cdNyv15aeWhgDAEoO
 JqVJ7Znmnx3dDMrpTUu+fmojkKXUBARUkAa7U+e86jXq71Je2FOlyCqzROMn9kaeVs5Z
 da4b4vttx0u9vyGV2o0ui6+vE6LTywDmcHY6ywIDDV/BC8KtTNLhfyNcUg6WPQE7TadA
 X13BbFD1Sw9TREafVObzp/QthzEBevwy4mnBkG3dYDjHeyaOdIiGs+UJ45cwntEO2mdV
 9N1p8ypoRjIPQcE8CqusjsNf91YlH0v+Ws13JFSBSWaWLAVct7RpY99p3N3x6SbxqS6J
 Adug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795785588; x=1796390388;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MF2Q1V/EtvKZoMEi+nOXp1ZGTmXe2V1X569j2rje/mw=;
 b=NnzRwwzrx6cGU/Pt7mZuolKR6ZUHMo1ssjb+QYclq6Fo7siqZyN/WMg/eC7R8SgTj7
 uR/XkT5B3rgDtvIWccG+QIRzRAeMAbnTbkXi+WwzbhKvQkh2FotemMiuPn8gH2REJTc/
 VY9IrnojLeJrvDsRS6PbbK3+7pFCe/hBnJYTe+N9NddBQV3h7eZiUZt5na5fLovmmB3W
 aNb3i0y8bRRZCshn7iu9EsJq5hQxt5VzHx2uky+FI6C0lf3s5rIxjzm0sVFAgn3DxChh
 AvwG9GvWeG6tZkZdGYc8ZO5VyAU+Z2whUB1YLKgui2UvCMxptNXYI3Uqyd+JAH/6wYDM
 QZtw==
X-Forwarded-Encrypted: i=1;
 AL+hErHwEEBcpTLdFaYi0UrfWS8HqWe6JvRSMTJFP2APThPmgwvOGO4PQd+vyfEnUiEnmCVt27F4h+sMz09vM+fw@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8DAF4fLgBvuDsosExY5Aty9TjbFZX348TFkL24q/Ib/yrJ6yvq
 EPHq+xak3hvgLH5QReNv2G4Wg74ChJqOUSfLPt4rbEz9XT5/d/2hrH5CVhOIKQ1rDAo2RB1MJ0g
 LqcElvohwgbHNEgg7g6dwI73pSYHu607ZSOvZVcEzuAEGc+hjD+/RIjlwxbGqj0+z+Zj3
X-Gm-Gg: AZFdTZc9c08Ywo4V7PGKkjYtC59QqZP28YaHqCF8Zkhmka6NxrfxKDwLCTGzoPYWfCn
 4QVCRhFVtyNMRxf6P3ridzLtJGR1LBYd2u3086RaIs52oUfRJ80mQ3yLVekiB1X+tlO93ne41L7
 JSU9wrqZN8UvqYejudhshUdP4t+zhXRxdWGhii3kC0NhBMpFzsk46nwIKV8fsSBIPhXkeC13wzE
 ld/Pxg68AYavFO+YUVb6m4KrlCk0ypgZnqrULHK/KCR/AHIQFUjBr2jo2Irqap6uLLibOIIVY31
 fCxWfCKL2MW7nVQ9wChL+atJDW0/Ir6KKbuX7ewh5lJMmd0Eljs4h8oNCSiSi+os3+wzwbjvC3r
 KnnDb3rRfCv3yVt8h194OuVquymZmsBxheTl1bm3TAq4pXyWxisMltevVSK/xupM/w+qAVyX9ij
 oSJ6GBX4DBmCRSzcBjsX04q7/3aqcpP/SjosR7gH81uzwgbG/69qiss6FG+1shtS0wTivnlzGqt
 0rBcUGK+JBRsYrAeQFhINeTFPePk8CSEsf49dDua1VPz3eOnCGZ8UsDiSF4pOuvc7BTp1yFsFZ7
 KZmzXEI6MxjJ0FO+k1X9z5X6f1p3ohvuVORdSYdCZmBt5GuToLLHz/zyYzz26mWsOQdfI5py74Q
 yaB01HPsjN9/Jd+/FzmCiJlnqLHKK+iobofjAaOA3MjhciHlGDMDSmS1hUovd+1OTpVEDYgnnvW
 m/ZhiLCOpoD2/CA94=
X-Received: by 2002:a05:600c:c168:b0:4bb:81b2:c801 with SMTP id
 5b1f17b1804b1-4bb889238f1mr486000145e9.20.1795785588082; 
 Fri, 27 Nov 2026 05:19:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884ab091sm964358455e9.11.2026.11.27.05.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 05:19:47 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 13:19:46 +0000
To: Aravind O R <aravindor@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2
X-Gerrit-Change-Number: 2213
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2213?usp=email>
X-Gerrit-Commit: 28db47113dd19df5188c5f995d49c648e2c54c0a
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 13:19:46 +0000
In-Reply-To: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
References: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTMzNzI2MDAwLkk4ZmUyY2JlYWRkZTNiYWQyMTg1YzRjZWU4MjRlZDJmZTMwN2UyOWUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ae7d695cffb0c518baea6865b0378b7451cc1435-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWvrm-000000004cd-4Ajw
Subject: [Openvpn-devel] [M] Change in openvpn[master]: configure: add
 compiler and linker hardening flags
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, aravindor@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7963690461830019842=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7963690461830019842==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iKcTBKFR4l0="; charset=UTF-8

--iKcTBKFR4l0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Aravind O R, Arne Schwabe=2E

Frank L=
ichtenheld has posted comments on this change by Aravind O R=2E ( https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail )

Change subject: confi=
gure: add compiler and linker hardening flags
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: -Build-Request

(1 comment=
)

Patchset:

PS2: 
Sorry for the confusion=2E Still rolling out the "being=
 able to trigger a Gerrit build for changes owned by non-core developers" f=
eature=2E I will let you know if there are any actual failures once it work=
s correctly=2E For now nothing to do from your side=2E



-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e=
29e2
Gerrit-Change-Number: 2213
Gerrit-PatchSet: 2
Gerrit-Owner: Aravind O =
R <aravindor@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: Aravind O R <aravindor@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 27 Nov 2026 13:19:46 +=
0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--iKcTBKFR4l0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Aravind O R, Arne Schwabe=2E </p>
<p>Frank Lichtenhel=
d has posted comments on this change by Aravind O R=2E</p><p>Patch set 2:<s=
pan style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padd=
ing: 4px;background-color: #ddd;">-Build-Request</span></p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">View Change</a><=
/p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213=
?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Sorry for the confu=
sion=2E Still rolling out the &quot;being able to trigger a Gerrit build fo=
r changes owned by non-core developers&quot; feature=2E I will let you know=
 if there are any actual failures once it works correctly=2E For now nothin=
g to do from your side=2E</p></li></ul></li></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">change 221=
3</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8=
fe2cbeadde3bad2185c4cee824ed2fe307e29e2 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2213 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Aravind O R &lt;a=
ravindor@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Aravind O R &lt;aravindor@gmail=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 27=
 Nov 2026 13:19:46 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>=


</body></html>
--iKcTBKFR4l0=--


--===============7963690461830019842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7963690461830019842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7963690461830019842==--

