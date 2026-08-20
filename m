Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C80DC5DF82
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s6ln6uIVDJqw1fz0OxEjoP8/xE4oD8CA1/qQDJpoR7g=; b=nL6GMJ8irFwRlmjiWSG71s3sLi
	LvqKfRTyEHB3y/wQwWlVKO6JGFtz2BIAReyC7yJiwUrD82/xUcYdW+b9gOeGNKr9ZAsyl/mBkgoWi
	3CpfIZnRnNbLxcdAiT3GnM4lIyz6rHUlzWSjtUpQHFi9pP2tLsHdqYqTGvM9R3hPABuo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwzar-0005XQ-Jt;
	Thu, 20 Aug 2026 10:01:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwzaq-0005XJ-JI
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:01:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wiZ2JRC+hsE+gStdT0VKsGbKm8wpDV+xUcBS+JuqOZY=; b=CUOM6CKh+uaLZPSL6xICdBBbkT
 7skafwNCxABq+V3xguZikqjZ1NpShzOixyAbLIZb0tVjX/emK17B/Dd84odR4EDvTZ2+38Q2SfQ9l
 I0clT+f0JUtkWSx/kU4hFIsl/XfprDONbEhaLiYaseB2Glql4Nb9dpLKntRpljDZ+J9k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wiZ2JRC+hsE+gStdT0VKsGbKm8wpDV+xUcBS+JuqOZY=; b=V
 rBVCr4I89CJYQ83/PCltVM1WbWoVG62SawQus7K8ceuI6PORI7jN85rtame+8CIFGuSXQLQCp6Zy5
 Oa9eNRuwp1DBp5tOmWMEsOli0JpVTtuxFV2ILVcsZG7rB7BAtsFjUN84oslTg87Z+FHmy2fue2Azj
 HL5JZj0fdcE6GO8I=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwzan-0004Ml-BH for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:01:53 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso16014905e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 03:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787220103; x=1787824903; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wiZ2JRC+hsE+gStdT0VKsGbKm8wpDV+xUcBS+JuqOZY=;
 b=S4JVazyE4vJmklZpllPB40Sw4VtMBN4sPryFuSwQqv/cnLU1v8HArg/XvJZzX0l5YC
 rmIbC59nkwg+gF650zLX3qUVX3L14Wh76nJABoKEUw2fVtiacAtQkT/kHf8/KIEFvl8G
 jXSE7wWkqD9VEmllOxXhFv8IkaqXUtek7JZRqSFY985JneGi5ZmOTgSaUHDlB3ugMasA
 np1UfU/gApIhAhgDrY4BTNeYXsp23pjT9+pS+gDko4czq+rqR3yx/LLJAIpYk81DO2rt
 NBQ9L4GPi4UZ6q/orw7A4Yj5Npfk+y+oLhHSN7Jc/iDFfZ0sELM28s3YtFO7LbYTv5gM
 +GsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220103; x=1787824903;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wiZ2JRC+hsE+gStdT0VKsGbKm8wpDV+xUcBS+JuqOZY=;
 b=eYmWwx9IH2MBHORnu8QY0W4qtoSxkoYuhyntVpO51yb15Y8WQ8GPTpSWPVCNCG5eJp
 H/EW5x6A/sCuW7qXp4gKM7zMS5ZkzIsrXKz/ySkdJ31SMKBBHK77CdjMEMZBwz6NQO7a
 yA5e2S1BvvLinkIs6kMrWlaE9CCtyly04NsrS0jvBP5O3OcysdF1aDz+T9r/5Da8+VxT
 AEIQayW7PmD9/xhGLULH/uefgCxMcmDKvzf8oArC/revLHbS3N6olvZ9KY7rfpai6QJs
 xyqbZx308QehI4NDnNUjVt0M3DOpkNTY/gRQBNzh9vy1dt7zr87S1itr5TQajpah8y+z
 OBsA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFCWotvgrFRI4xe6FF5KFRUVdeFWX3FX9a5YTInwDWh09XmYjelR2RdIESFW7n4wGl+4LAJnJ+nY/TzhDN@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxXpP+R+OZ7pYLVf1osk95EwlIDHdTTJHl3MMHWcrHcmwUepISn
 AeGPCP61hNlbea+Emb1Im8soBddPE4Z6WnHiqAqIBLcHVdAjFUQV8fK6v2ECusnr59tfzccB80U
 /cM00DA7nyJqUsTjPv2O+FNUH889giVIj2dP2L0XmMecYQgy5BRojCPnt0g660OkW3FwZ
X-Gm-Gg: AR+sD12Kf2rqyQmkTcFbDHGgg4xn7jvp0cCIlCXPzc4U8zIOaCXWW4B/ACX2qinfL05
 k9AYXmtstXO2uo5aaGCHDb6XuRErOofTUnVaAIo5wISenn1tsDA2kgRs951ipV7gOko4IsYZ+Rd
 6U4ZXgrDt2VXplXA9tcpK3E3SKfZ5HRB2aNkWZMPLqAi5r11pkrIOQHh1XnntGnRWmVp4TB18A0
 x4B0AURlLr8IIf1mzrnDxCcTN/0DLAPCpLXKgVKQAshKSENynYAJR3fZ62GArCbWvjt81jxPvuH
 Hn7qZcyPD3dXUqU4Xx0eHaEeNzOTzffLyBygwEDeKez1UpXx+gibYCacPYUgfX22CsY9mAlE46Y
 kGIsXzU2nv6itb6n55osx9GXPx7en1DJ3UKck9IttTuOxCTS7FOmzSCiyOFtTBxQwhnCEbemKKJ
 6ma1OZrI2xFcUUTfsr/sy5f3ILf31ItcvYHACbxcwOmIPBKBieWxnjT3VVLS6TOM4zYGRDIHvm5
 76BboR4oNbHAEh3hYFoIv9NwcfjJgsc3Sba1Ld5RDZIzXeJ3wohaq7vcfoPe8DQ7t8xm70C+gC6
 1znXtDJ4m/Fgy4RNvbZYoL6PUIzvLxyYj7hTBcxevJQj4TsfIUo=
X-Received: by 2002:a05:600c:8a1a:10b0:499:b001:b8d4 with SMTP id
 5b1f17b1804b1-499b001b8e1mr92875395e9.5.1787220102626; 
 Thu, 20 Aug 2026 03:01:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b2b96537sm30442275e9.1.2026.08.20.03.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:01:42 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 20 Aug 2026 10:01:40 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I80a94dde26631e5a665029f495b2104cfecb1915
X-Gerrit-Change-Number: 1792
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1792?usp=email>
X-Gerrit-Commit: 718da44ae0e0c3164b55df79ea27ec05814231a2
X-Gerrit-Comment-Date: Thu, 20 Aug 2026 10:01:40 +0000
In-Reply-To: <gerrit.1784305303000.I80a94dde26631e5a665029f495b2104cfecb1915@gerrit.openvpn.net>
References: <gerrit.1784305303000.I80a94dde26631e5a665029f495b2104cfecb1915@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLkk4MGE5NGRkZTI2NjMxZTVhNjY1MDI5ZjQ5NWIyMTA0Y2ZlY2IxOTE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f31611a0341593498dde313bbfde8bea4c940de6-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwzan-0004Ml-BH
Subject: [Openvpn-devel] [S] Change in openvpn[master]:
 dev-tools/reformat-shell.sh: Make our shell code more consistent
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6281726742489239220=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6281726742489239220==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T7Eb//P6II0="; charset=UTF-8

--T7Eb//P6II0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

ralf_lici=
 has posted comments on this change by flichtenheld=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1792?usp=3Demail )

Change subject: dev-tools/refor=
mat-shell=2Esh: Make our shell code more consistent
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(1 comment)

Patchs=
et:

PS4: 
Sashiko again: https://sashiko=2Edev/#/patchset/20260820091512=
=2E4550-1-gert@greenie=2Emuc=2Ede?part=3D1

Haven't checked the actual revi=
ew, I'm just forwarding it if you're interested=2E



-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I80a94dde26631e5a665029f495b2104cfecb1915
G=
errit-Change-Number: 1792
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: ralf_lici <ralf@man=
delbit=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: T=
hu, 20 Aug 2026 10:01:40 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: N=
o

--T7Eb//P6II0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792?tab=3Dco=
mments&amp;usp=3Demail">Patch Set #4:</a> </p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Sashiko again: https://sashi=
ko=2Edev/#/patchset/20260820091512=2E4550-1-gert@greenie=2Emuc=2Ede?part=3D=
1</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Haven&#39;t checked the actual review, I&#39;m just forwarding it if =
you&#39;re interested=2E</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=3Demail">change 1792=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I80a9=
4dde26631e5a665029f495b2104cfecb1915 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1792 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ral=
f_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 20=
 Aug 2026 10:01:40 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=

</body></html>
--T7Eb//P6II0=--


--===============6281726742489239220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6281726742489239220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6281726742489239220==--

