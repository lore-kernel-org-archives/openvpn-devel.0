Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E82CD5BA4
	for <openvpn-devel@archiver.kernel.org>; Thu, 21 May 2026 10:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:Date:From:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dBUgjOQToCVUhpzYyiE5w4kFmUeoTzm7wRHhVtak/Gk=; b=IS7IoLEphWj/ScQHzkARmO9S+H
	RlKN8rYW1pVfxSAquk9k+Xh3Pydfx5gtIiL5tG8Lvdupu8rVU6IASKPZevzuM/CA56mc54OXrVhZv
	0o4eEdn944o84oWUl3ryLwUvTBDudlZrBFbRVB3COozNNR27gCSJbO+uIQU+uwsy/+l0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wQ14N-0003Pz-H2;
	Thu, 21 May 2026 10:56:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wQ14L-0003Pi-LJ
 for openvpn-devel@lists.sourceforge.net;
 Thu, 21 May 2026 10:56:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Rlill5XufAaxZzck2Sl8+AWkgva4rc7tEG55JAI06mc=; b=Ym2koxvfNl/lN+uYk/SMspU3GD
 9MTxuAaz7DxAchOfC0IZhZuSb2V4M4pgTnlU07IqpuB/cvh8ACUZ9Nk/5srlNv4SzR/Qle9V70951
 4uaz8pa471IsZqhsl9aro455Xv/AFUtOh7EUoT5cn1vFON+wzk9J80cHoTE5a+F0Q7wg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Rlill5XufAaxZzck2Sl8+AWkgva4rc7tEG55JAI06mc=; b=P
 z/r4Uq6ynm4qC78KArnKeALncWF2sex6uQ/nS9/9j70S4TGWlYyOeu9fOvvZ8t9hJ9Eb5Gre5JERL
 9mTs/mHVPNz7jRISbC9Wcwddgy7j179tII6hRMStmWgy95URWbKZVGsDylQpGe06l8gPPYIF9mVST
 AfcU0l7gOVCajsbI=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wQ14J-0000Uw-Qw for openvpn-devel@lists.sourceforge.net;
 Thu, 21 May 2026 10:56:02 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso78622055e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 21 May 2026 03:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779360949; x=1779965749; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rlill5XufAaxZzck2Sl8+AWkgva4rc7tEG55JAI06mc=;
 b=QM/a0tPGRmZt1R7+8t58IYa95ac4daLQaemC/QAOq4zFPv7fUY6JXfB8tfBX3EtaCs
 ngmkE9vW93iWx+tBME6QF6RTnjAEgopncY9DcVS5vKnwvqOB6iJ0RwlsJRz/ocXyIZMb
 fz2Cci1L0t6FSEs9D+yGAww/IpsqFO7841w90JfqrvAKg+DjyedQc2uMM6UQyCiNIV/o
 2ACbqELtGQ/hRt5MxgzXxAlLRZBTNyNiisFaL1I5/XTthcRqmQIMuPoSWiIoPKdA5y3A
 s3xG2DCyUMyQTomSTVyIzbHlUvPLQGi8+MECBsosiEF82pFuhfHnpBjQMKBKmVLP8ZTx
 XcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779360949; x=1779965749;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rlill5XufAaxZzck2Sl8+AWkgva4rc7tEG55JAI06mc=;
 b=C+RetzBAxtBsfddsE+X1Caq0lm5FYv7H5aeRcbLO/GF5wUuOrSUhZaAZSutn92vThg
 lHPgewoQXwhiureoVaai9LoVc+JxnnG0DtNwkG28vaA5ZadHxIN2bP86Bls+nqQ3hNco
 46j9mylsd4ky9MeT0mfBCwAu/7B0buks7355XdTRv/9SmHDUX4d43g6HOhbWSnCsfcU4
 FYsqC4VwJWsdrCfaqi4n5FmOwCAj8TohQDhpoYP2VRASXPuxaDXq23sHspqFNHjbHb2M
 g5kKeAcK08eEf9oLXHmjuXo03CswV/bl7WeXaHcbF6Zogv/obpwxM8xHtNg55wcLsj7o
 ayTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/GpJw/yRCanm4F4oZuEOsnwgKGsltdeFIW48MSJiuf5yuQwY0qfdDh0PomfEw72VxGA7qbOi1kqBMLrv/@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxkhPsSqWdOUZYEGa5Ko+ZmBPaZ7HZMgdY1jrNE878ji3jUZ8pI
 o5Z43hPfnHeaIDOeuotsXplnUa9s3jglMnYERHC6FErTP1yb2l5Yrd+//5BnBp2tGOUa8deK0T3
 GSjKel0Wsbit/tEfYk3mKd1X89v8i9eUPeqfKPRjV5zEYJ1+ZXDFeoSSTRDIZ27XOFOXs
X-Gm-Gg: Acq92OHIP2KAn3uzFVhoIZzgqpj1yQtfitIU4/EgA/CRlufTg98Wv+jQtkL54Vd5CB1
 iBkvA3lIdhhOFhfRnk/7wWD1XPuYmnS3DMFJFcSYNlhUopt/PlwaYZYJLTh91D/Ojfidqq+T+yz
 tbbCWBxslQowX6QUF9Obbvi/YtLc6c9kusWMpT6vZD/Mx94l2jtV3755B0/VJgg84tqI+KDlXIq
 NT7jGMzA2PtK5w9o2NWfixQ9724pw68Pa4wiZrzU9m6Ay1YjoA2zYXsOnb8a0kgCOQDKTDZjeUu
 kiQE6ZQjEyEoZjjjDv+VeiJ09D1iVX+4Q1qVsC1F0c626CplA0xMc5rE387jrQFdAegoU4gpn/q
 9+SV6uO7gyZwW4fE3RKnJBDUhhL5D6lnxvWco5qds9pt/Dp+aldHZ8ofJ4NLXJtx2RBNqZaKtLI
 H4c9MF6hdeCnTlspicg1px0I7Nz4WUzczbgjdQFNbb27mqZMbJ31WHXLdfKQILBOqIrvm2OoSmo
 s6jSqy0IT+LcmVNpleQIRAMnncga+LGeh8UKjYNInifFQ69GFwwpIIvyjbNZlW2TrtlBs7ZIuW0
 2CVFiEOP6Z6oV2UrtwkKtK66
X-Received: by 2002:a05:600c:1f89:b0:486:fba7:b150 with SMTP id
 5b1f17b1804b1-4903606c383mr31034595e9.15.1779360948378; 
 Thu, 21 May 2026 03:55:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903cadc119sm14646215e9.11.2026.05.21.03.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 03:55:47 -0700 (PDT)
From: "flichtenheld (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 21 May 2026 10:55:45 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
X-Gerrit-Change-Number: 1675
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1675?usp=email>
X-Gerrit-Commit: e9a0645e18dca96e910a41a4ca85352d3298f79e
X-Gerrit-Comment-Date: Thu, 21 May 2026 10:55:45 +0000
In-Reply-To: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
References: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLkliZTdiM2MxNzE3NmM5N2ExY2JiNGQ5Y2M4NzczNWIwNWU2MmM0ZjQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4e2ebdca2b7a93e36e6b472333e2099890fe2a68-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wQ14J-0000Uw-Qw
Subject: [Openvpn-devel] [M] Change in openvpn[master]: lladdr: Clean up
 code and BSD support
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2589068307702639125=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2589068307702639125==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gUjm9NWBKCg="; charset=UTF-8

--gUjm9NWBKCg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

flichtenheld has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1675?usp=3Demail )

Change subject: lladdr: Clean up co=
de and BSD support
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 5:

(1 comment)

File src/openvpn/lladdr=2Ec:

http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1675/comment/af472c1a_62989ac4?usp=3Demail=
 :
PS4, Line 31: #endif
> after testing, I would do a new round on this - b=
asically, "lladdr" and "ether" are synonymous on Fr [=E2=80=A6]
I think I h=
ave addressed all the comments



-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1675?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
Gerrit-Change-Number:=
 1675
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Da=
te: Thu, 21 May 2026 10:55:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labe=
ls: No
Comment-In-Reply-To: cron2 <gert@greenie=2Emuc=2Ede>

--gUjm9NWBKCg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/lladdr=2Ec:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1675/comment/af472c1a_62989ac4?usp=3Demail">Patch Set #4, Line 31:</a> <cod=
e style=3D"font-family:monospace,monospace">#endif</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">af=
ter testing, I would do a new round on this - basically, &quot;lladdr&quot;=
 and &quot;ether&quot; are synonymous on Fr [=E2=80=A6]</blockquote></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I =
think I have addressed all the comments</p></li></ul></li></ul><p>To view, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail=
">change 1675</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/167=
5?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1675 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichte=
nheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 21 May 2026=
 10:55:45 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div styl=
e=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@greenie=2Emuc=2Ede&=
gt; </div>

</body></html>
--gUjm9NWBKCg=--


--===============2589068307702639125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2589068307702639125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2589068307702639125==--

