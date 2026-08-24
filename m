Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8047C5DF94
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Gq/KbYIBNnnHScUVAT4BEjldCHNvTTMsBZ/0ekVPFk=; b=NRYxoVELNxWwHeNIWgHOZXEtmd
	VmmnJNbbzdwBY/0nbZm1OHkHmDx+ALbqFO8qbwAzsoiKW9XfZGYMnxTt5gkhBR1U0lPfm8APNgFMn
	QBc72ywDZJ9fLmtJnOldlHYP/lrDcB7JDkd0MVuOpTOIBnvX6RPtwLGHxSyGPyBAnYhM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyWfN-0002pw-Id;
	Mon, 24 Aug 2026 15:32:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyWfL-0002po-Q2
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:32:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=FFleuqX4wfWgB2IyejhBHoiPsdQRa3NjtIDNc2VrSQU=; b=QDWWOgVnspko/GFWGXAq+kJdw9
 O1gp84SLo07fvp1YxMLDKQx3tQ2IOiz2l7gw5MjoqDBdAFUz8/3xRuwVU/G8q8E9sLjBTgJ/OXlHD
 9cK56kYhMm+ySRvhsiFUfTjGgs8yAQH6zsclPMVnHmHqqlQcJVdLc03RR2hSAlxiiMzA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FFleuqX4wfWgB2IyejhBHoiPsdQRa3NjtIDNc2VrSQU=; b=O
 wD2QHl4aCTgahfNZPsyJ61XhM2391o8Y5oz6UVwxQiPxl9HKPJLJyrI8sE0qsZRJuU6wi4Yric2Qe
 pN2L6AC1r1K90XLgbbV1yJM66vQ8Q7jzS52hpHuItqT4JKvB2ck6eT70mHTTCFnb6ureQf/c4Xwa2
 p+MxMq2YN+d26F7A=;
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyWfK-0005kX-Te for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:32:52 +0000
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6a17cb94b26so6877391a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787585564; x=1788190364; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FFleuqX4wfWgB2IyejhBHoiPsdQRa3NjtIDNc2VrSQU=;
 b=N+9AwUP6t4Bb1wc6G8oyt26j+qhKyprM881NHaz698oXzICnKV0uW5MXi4kRl++etn
 NQnCFUGPBGe2cilqA+JorcIhQy0oMmEpQyXZ4FAylsaEvYuKHtW9LBHl+NgT1Oqf2WPQ
 yy3nEGENdLgYrF/la2MrjtRZRPAkXJ5mTqFKDWuxcLebbM9OUo+eNEQxBqjfWVxS64hB
 DSA9yPecojTdRCRJ3MdxMyE9Dh9VdW+FLYDOqm2MPkD1LziB4zEsIM9Ri3y8ELIg0MDw
 VKYXy+M62wv3u4TWoypXyh3Or4xhM8HDVOOLmmmoYgPxdw8ihIcfPpdFb3x8hkGRUShB
 cT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585564; x=1788190364;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FFleuqX4wfWgB2IyejhBHoiPsdQRa3NjtIDNc2VrSQU=;
 b=Oj+x5yUPVrm2VHAKCUJbZjjME+1H9kHUxckf89za6DxC0FGG8OjDH0nN89fUQ6FMG8
 5gZ3VXLxsql3frH8XPidZMFe08B2CCDasRK5M5vM+iOplUdsE2dZwNW3AN77v+T4IulX
 wdlcPQ3zcwM2CUui+uWLURfyf0CclWhm8eF5H39hMB2VsACVJX5doohvWt0T9tVr7Daz
 +94h3AZ2oU6Hfk1Vcw/tsxDIFgj/i7QG6Ad4fKaPpuO9KlhTV+nqHbDf7/mL0CaFXy9s
 jBf2YFVTNqMuDAVxAcdDDaDrajcohrxV6/+uVUWPKfggUAxTyjRmqbDH6aS2oinIDZ6w
 Hvqw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrY3pVLfwYBiFGROIwN6K7dU8tcaD0FRgQOhk5sV4knQC2p6hj7lCRLxWOqQHnZ2o7Z+z+Ymk128adLkLpw@lists.sourceforge.net
X-Gm-Message-State: AFuF++lXdWrr+lvq6/xctotpnqHMbTHt0HbVb+C6rS+U1wBjFAP5olYs
 tjoIDtOwTLnXnK1C2n9xgl5YQiscvBFk0zut+Sifgy/OOCv0qtcbvo1ZV0HH6gAvDl9cLnWSIxR
 WB+QtcqOf96aB7TkJ2qh3NPVvYz43YWy/zF+/LSF7BHbiENLv+QTCY9P8g+Rei3PABIKV
X-Gm-Gg: AR+sD11iA5QH0sfLAyQX/xKauCTNDzW4Iykd3TGrAIfakKDCjN5E0Gj9eVdH/QJhkf7
 lERcSEsH2kJxMX3mrli0i0NWnV+LeOXA6cnzIwr8Sg3UX4saszR0McTm0OnYXQW5jokF1gsyHsT
 ZZ8zGWB9uB634d6HguxRiRb79WLNdyccJGv85QnkjLFFjmnmz7mscjio1P1qEbl3uDrpSCRZS8j
 3OfLgrQokj//xYmR6P4hfAcw8aCjMGk3MdQAwGzBG4LJIGGoiBh++Vz8PtoKRTREdKKVOhwsYtl
 W9/LwCa07XFDLYev8npcQuoIGm7xkMzbeMFmnKEF4aqYAvmAHb3DSWAoA5UVdVUOy+QY30nvA6B
 H5dxuYEVhgAh8KAtynWqs5T4PCi6GS/7K81tMCc7TaYn2o5s9wa8+HUdW7rq4/R6uTZNEHLmvXg
 nHXPba/jYwOR96l4pE3fob3lamF2c5zLfQSvvJ1yfr/Zvk+zN+591X5UklDQQyUeZqUKNEeKNDO
 RpRavB24smFqbRksc+vdfHAprRhvfr/K2PclnFkeItZ/LAMG8jSEjVrD/ivfOZ0euEjIsaWvBW/
 2iGGuDCkBt5LyimDcExjurOBVkOoA5+0/B/H8YBZen6lRxsKGaM=
X-Received: by 2002:a05:6402:1ecb:b0:6a0:dda3:83db with SMTP id
 4fb4d7f45d1cf-6a42eec0421mr29567493a12.0.1787585564075; 
 Mon, 24 Aug 2026 08:32:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e1d741asm9188604a12.27.2026.08.24.08.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:32:43 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 15:32:42 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I52773764e0f4056fe5367918a9b2e6720b165c21
X-Gerrit-Change-Number: 1585
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1585?usp=email>
X-Gerrit-Commit: 191008d2ddc2c92f584bb9484bceb4193eaaf661
X-Gerrit-Comment-Date: Mon, 24 Aug 2026 15:32:42 +0000
In-Reply-To: <gerrit.1774268486000.I52773764e0f4056fe5367918a9b2e6720b165c21@gerrit.openvpn.net>
References: <gerrit.1774268486000.I52773764e0f4056fe5367918a9b2e6720b165c21@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0MjY4NDg2MDAwLkk1Mjc3Mzc2NGUwZjQwNTZmZTUzNjc5MThhOWIyZTY3MjBiMTY1YzIxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f7087e0c641f1d2bfba5712ed82eda450a4d41bf-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyWfK-0005kX-Te
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dev-tools: Add new
 script to convert mails to Gerrit patches
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6348249093968062646=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6348249093968062646==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ktXJjIAOMbg="; charset=UTF-8

--ktXJjIAOMbg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1585?usp=3Demail )

Change subject: dev-tools: Add ne=
w script to convert mails to Gerrit patches
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(3 comments)

File dev-tools=
/gerrit-submit-from-mail=2Esh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
585/comment/1626c89a_aa90ebae?usp=3Demail :
PS1, Line 18: TIMESTAMP=3D$(dat=
e +%Y%M%dT%H%S)
> This timestamp looks broken=2E `M` is minutes=2E I believ=
e you want `%Y%m%dT%H%M%S`=2E
Done


http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1585/comment/b0137a42_40d14fca?usp=3Demail :
PS1, Line 22: git -C $SOUR=
CE_DIR am
> Should we check if this failed?
we run under "-e" so it should =
fail the script


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585/comment/65=
17b809_a55216a4?usp=3Demail :
PS1, Line 37: if [ "$warnings" -ge 0 ]; then
=
> Isn't `warning` always `>=3D 0`? Did you mean `-gt` here?
Done



-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I52773764e0f4056fe5367918a9b2=
e6720b165c21
Gerrit-Change-Number: 1585
Gerrit-PatchSet: 2
Gerrit-Owner: fl=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailb=
ox=2Eorg>
Gerrit-Comment-Date: Mon, 24 Aug 2026 15:32:42 +0000
Gerrit-HasCo=
mments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mai=
lbox=2Eorg>

--ktXJjIAOMbg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3Demail">View Change</a></p><p>3 com=
ments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>File dev-tools/gerrit-submit-from-mail=2Esh:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1585/comment/1626c89a_aa90ebae?usp=3Demail">Patch Set #1=
, Line 18:</a> <code style=3D"font-family:monospace,monospace">TIMESTAMP=3D=
$(date +%Y%M%dT%H%S)</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">This timestamp looks broken=2E `=
M` is minutes=2E I believe you want `%Y%m%dT%H%M%S`=2E</blockquote></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Don=
e</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585/com=
ment/b0137a42_40d14fca?usp=3Demail">Patch Set #1, Line 22:</a> <code style=
=3D"font-family:monospace,monospace">git -C $SOURCE_DIR am</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">Should we check if this failed?</blockquote></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">we run under &quot;-=
e&quot; so it should fail the script</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1585/comment/6517b809_a55216a4?usp=3Demail">Pa=
tch Set #1, Line 37:</a> <code style=3D"font-family:monospace,monospace">if=
 [ &quot;$warnings&quot; -ge 0 ]; then</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Isn&#39;t `war=
ning` always `&gt;=3D 0`? Did you mean `-gt` here?</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1585?usp=3Demail">change 1585</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I52773764e0f4056fe5367918a9b2e=
6720b165c21 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1585 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D=
"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razv=
anc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Comment-Date: Mon, 24 Aug 2026 15:32:42 +0000 </div>
<div style=3D"displa=
y:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit=
-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: ra=
zvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--ktXJjIAOMbg=--


--===============6348249093968062646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6348249093968062646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6348249093968062646==--

