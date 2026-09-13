Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61E2C88E40
	for <openvpn-devel@archiver.kernel.org>; Sun, 13 Sep 2026 09:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tOCPxi46r54MSGX41eYMx3pTNO+HGK11K9IymSdBXAw=; b=B2T8qF4av5omQYcrmX8Y/WVOpe
	cvuayqrkATSIIK/Wn4yq62+TpIUOmZEAkk/vN/upV2PmIGScFi7qYAPetyk3CZJYK7DcglJSrO7D4
	6Ghw7xU8TXYcvTrGRAP2PB4s40spGhwhwmyEqTaPder+rRSDfjOx+bzCnYU1jyCty87M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5gsi-0007nP-OL;
	Sun, 13 Sep 2026 09:52:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5gsh-0007nI-G0
 for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 09:52:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=j8rPYqss109IfeL3NpL4lzjkF8LuB9GWCer7XwPJ+TM=; b=A/pQYoRGYKOdwlRsQcJ8jOV2KP
 gND4FoSZiGGlKor3Kg7scu1DCef5rW6SW7lzDyTGQCH+rxIL9D9f+HDci3BO/tV7+zz+LBhXB5iKE
 P+uL3G01O4FgMw2b4uFbnMezzWBxV0Zjt6QS+Q7ScUtr9PIHruMad1FylZ7oB1k1FKac=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=j8rPYqss109IfeL3NpL4lzjkF8LuB9GWCer7XwPJ+TM=; b=l
 bbWzsSWLzkReuCxhEvC16iUPx5RwIKwwuAs6eiAMv/Oqr44ZAZ4w5+qnbSnaDzsbXHDrm4iVPVosy
 7AuOU3Tn9gCloQChwDlCfufnMpYo0tThs/ecWadOP+fJcYC8jaEkna6MiPS6xP7YWh2pkR8UISi/3
 lOrKEenViriMVpYQ=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5gsg-0002Sm-1U for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 09:52:15 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cc9f581c4so3311165e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 13 Sep 2026 02:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789293127; x=1789897927; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j8rPYqss109IfeL3NpL4lzjkF8LuB9GWCer7XwPJ+TM=;
 b=HqFjq26PAThhCUnlLTdqJo03c3sI1xhwKRiUynPaArcNYbf39ksY4hGaPBD/FaGS31
 ugPuyrEAmQSlHoTxz7K+hs4ZXVlJQDI2RCkT75k+X7OurAMJ3RyqB8MKRzyJsZKb1ZF9
 Fkl+hTqVq6bAR8GL24zIV5fvR4Tu/elU+ql+bnyEPxJkcgh0U7qVC+BAwurzYJiYPHMF
 57qln0lrihsac5uTDficlY/Hb6R7Ru2NlF4n1SCuhRFPXDobzeI2UZ8RyfpNPnUWwFfj
 kVoNzMNdfySAC5YoViDQRFSjgl/Oy222+4FcqIHf78Q/rRhCygwOp7tth1kD3r/PjicC
 O4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789293127; x=1789897927;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=j8rPYqss109IfeL3NpL4lzjkF8LuB9GWCer7XwPJ+TM=;
 b=JvvwCL7zEmicYYzYJE24DrbPlwCTwnCEBEm9JoDvu0UFqdr0PEELc1YQKmLnjhYuWO
 34Li/GWB/rOWH/Te5PT1N8o9piIAlO/RmZ7wxydpvJXF4asfaThJLcx0duzfypAnJxEC
 MSID2E1Bw7OQ3ryttpR7WqfM0NxQmWR2EJrhzdEttCEDYzs5dn0OpM8SBr0fosUutsfb
 q3oCNFHXfqztc8XYDELFvoG8kYvGTcWg9S0eqm19wOjc5JFfGfeZE73oSknQgR7gUqzS
 iCCotAvtsSzP/IOzGJ1YhxlxHARiDYIANtIDa4BBQkhN/hZ+/2BKedRsuIUkxhiUA5mF
 rKIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzK/4OMVm4/OlizjUwFhzT8SMK3jyktFZC+DpyQQCyV5CT34ZYXQd8zE46mw20LZjPVUkN25LBIM9tlxrL+@lists.sourceforge.net
X-Gm-Message-State: AFuF++k2sYfE3FncxYB0TT0k4P3zUSDx4P9k+3mJIRzcBqe1sTmkGLZn
 FxKXrjDbi/n0KzguonmA2wRZhXNQrDIU2IDIna9JJ3ve6WivTU6JsrRKX9BUx1o2huy1Va0ltyi
 fG3tSTDYjjjT7Fbun9QwXt/B9D6eaSPbyj5GWSWpL+RyQppqcna9vQcsf8IupyXkY+0Lx
X-Gm-Gg: AYBFou2h+804iNdkhKm9LN+R0iOEFhMu2S1soEEutn6HLofk/YrR+VuFNangF8t3yp9
 HARLb1F3eVzWH5eOFxHGnfpGKMzGXMleKS0HFT7PyfX91Sc+tZxOK6DBJxiUpaLaLbr2LxYx1tj
 b+K1/z8FpJqSrbBGWfQqXlgrwFhuBQLTFO4NXFiwjVJV41ISjsXOyaev+z7ZpU5ur/GZzrOiG7n
 CPIau9Q3ZAN1kKIbgC9ict5jCrDdfZBCKFGtwUXeHtJUuMcsuMlbRE12dVEi9K+PBYxvvucF9KV
 EoudeavsQJCb6veV4jSpFbVF2i/emmiuSZxfmpaSwqH8cvL/i2eSgP/gInfA16vi+m6bOtFPJMQ
 tCGd8lH4nNrrDLiqKi+0sDvSaASZt+/nKPdY2Oq4QX3TQSuIMk5dp9WO3lfRnwV7DaQVmbp+2Sh
 8Q3DH1VemvQixw63CydcPyfexLrvW3uAVKuPIFqtG5CSgbpNM7TIIi+L6cw4kgHvTVFweYSa2bs
 mNn2SpfZkbcbAoiJFgTQGAo6m24YY9WMHlcxx6IO8WDkXlJhS6MkE/6q9JOVBqq4bkFgipGR3b5
 m/blcA1wOxGw9pvujXiNwFNiVG93kSGwdswhyVrc2e8bDfGtdZrCMI7j+1xf6w==
X-Received: by 2002:a05:600c:b95:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-49e7602c6c5mr16855765e9.5.1789293127344; 
 Sun, 13 Sep 2026 02:52:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26d4e3f3sm338822725e9.15.2026.09.13.02.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 02:52:06 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 13 Sep 2026 09:52:04 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
X-Gerrit-Change-Number: 1617
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1617?usp=email>
X-Gerrit-Commit: 35aca022b11f9efa8a8f0f3eef5c632a9c52102b
X-Gerrit-Comment-Date: Sun, 13 Sep 2026 09:52:04 +0000
In-Reply-To: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
References: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLklkMGNhYTQ5N2M0ZmYxYWQ4NzQzY2IyM2YzMzJmMDAzYjJkMzM5M2VkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <98883218df6337b3db93decfe37a2d19926ab1a7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5gsg-0002Sm-1U
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove various
 useless assignments
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com, gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3056585379269053255=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3056585379269053255==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HRcWQxXCYPk="; charset=UTF-8

--HRcWQxXCYPk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
zvanc has posted comments on this change by flichtenheld=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail )

Change subject: Remove var=
ious useless assignments
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 21:

(1 comment)

File src/openvpn/push_util=2Ec:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617/comment/964dc425_b42707d9?u=
sp=3Demail :
PS21, Line 134:     }
> this is changing behaviour (because in=
 the `else {}` branch we're no longer skipping something), **b [=E2=80=A6]
=
It is not changing behavior=2E The `else` branch did this:

```
i =3D strle=
n(str); // this puts str square on its NUL-terminator
```
then:
```
str =3D=
 &str[i]; // next while (*str) will fail and the loop ends
```
So Frank's n=
ew code is exactly equivalent (and arguably clearer)=2E



-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d339=
3ed
Gerrit-Change-Number: 1617
Gerrit-PatchSet: 21
Gerrit-Owner: flichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ed=
e>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-CC: stipa <lstipakov@gmail=2Ecom>
Gerrit-At=
tention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Eco=
m>
Gerrit-Comment-Date: Sun, 13 Sep 2026 09:52:04 +0000
Gerrit-HasComments:=
 Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@greenie=2Emuc=
=2Ede>

--HRcWQxXCYPk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail">View Change</a>=
</p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/push_util=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1617/comment/964dc425_b42707d9?usp=3Demail">Patch Set #2=
1, Line 134:</a> <code style=3D"font-family:monospace,monospace">    }</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">this is changing behaviour (because in the `else {}` bran=
ch we&#39;re no longer skipping something), **b [=E2=80=A6]</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">It is not changing behavior=2E The `else` branch did this:</p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>i =
=3D strlen(str); // this puts str square on its NUL-terminator<br>```<br>th=
en:<br>```<br>str =3D &amp;str[i]; // next while (*str) will fail and the l=
oop ends<br>```<br>So Frank&#39;s new code is exactly equivalent (and argua=
bly clearer)=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail">change 1617</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id0caa497c4ff1ad=
8743cb23f332f003b2d3393ed </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1617 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 21 </div=
>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &=
lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;=
lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Commen=
t-Date: Sun, 13 Sep 2026 09:52:04 +0000 </div>
<div style=3D"display:none">=
 Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--HRcWQxXCYPk=--


--===============3056585379269053255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3056585379269053255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3056585379269053255==--

