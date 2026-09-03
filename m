Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4E4C61DD3
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jOvzuR51Zxxx+d+IiZVZk6GHjm4XNtx6nAZ3lD3Xb8I=; b=Qj5hRWCb28bey2aQCMsJcxT3kP
	S3ovlvayWb84zXszqn83xxyPeeU3HbZz+K3WW4jlezmUw9RbMWzHBti4mV8b+8xP5I+k+iTPQYQQH
	STo4Ie0e8UvOF49anzvDzjvpMPymrYCctWycC+XiqPBSUObf8gP+6F8MFXsNOEnEAq30=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x29aN-0002Cq-54;
	Thu, 03 Sep 2026 15:42:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x29aM-0002Ck-8G
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 15:42:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CIkH7xR29R7OdHKDo3XhZ6o3Io4E7HIOYFpeGF22ZEM=; b=QCNAEk/Wl2OSgUMY1XKvSCltAV
 F1BS56rvSKLbGj3ObsDro+cv5nL00SWCnTpSmHQ9Z5CzRUNbZ+3GxM+/G0+uDZpWJUVoDEfCecaDS
 E4NZ2QRB3wCk64Ju/PwNWurEBHFw82q44cU6WHCLK7WAF0iGjzUDhWEzgLVVzeayLTLY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CIkH7xR29R7OdHKDo3XhZ6o3Io4E7HIOYFpeGF22ZEM=; b=F
 hjTkVAyupCP7hywkT5yVYB5CpuQOgmAoTQMrIxVtENyaaDLjFkFmhHg2wFT7SaZ7l9i6L8V9TGTq+
 Zs3BMLEmj9QyS+0k6nB3GPQ7p2ii60Bg2WN4+ewsomI0amfViQ9pQ8QWZxyuieq691BxT13bHrFlE
 n2PAmg7MMzebp2MQ=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x29aM-0003Ll-6s for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 15:42:42 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49b965570d7so222745e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788450156; x=1789054956; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CIkH7xR29R7OdHKDo3XhZ6o3Io4E7HIOYFpeGF22ZEM=;
 b=SGkzseaz6MBSV5GfIJhbbwLl2wuKKi4BEhv/o6bu3wOMhzp4dbiyoth6MeByLRDyrW
 kK5PLDVb0BRRLjnLgKMBnPfFcrivlESAkj7gf28LcEyH7hNI1d0U7w1D9SqPtmh7FUDf
 OrnvhLzaCH4fvUcva88MmEQBikS4iqzOQn1WjCBKOaU9dYs0X7syCxLTdm8jrbF86nIC
 8E4Gz/wO/s8/+X+WtBtLNvi+a4HyogytiGtRZ3VAne06Jd4GKGJhy1EoBHA8FjgZNNpA
 3b9JoUC382mqHvo6/dUBto2Q5ObMZRvoetNjoEUDzYOMU979E5tTrMNgnw1yxnxvp4kR
 SFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788450156; x=1789054956;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CIkH7xR29R7OdHKDo3XhZ6o3Io4E7HIOYFpeGF22ZEM=;
 b=d1/ajiSHUHjBwvIqWDdQXAL0kuc7vfv8eD2ny8CVm+0pN3Yw8zw6vrcVqXEIMCKcFz
 hCP4hqc5vsbDP8dN+DbBT8Jp+VLnLSjRVf5SJ+t/1IY+3eCWQcR/Mw7A1+84PGvXm/Kd
 X6PBjQR7c1kaoHPxYvgsY4ygHOQxs9QpK4l+CrZb+TfJALep+iW6f7mTprwg0Ge6ULD7
 frZ1FvTTGevsyopbtpwbBNDeDzv9Alx8q1oM/GXLAxn2cxiXR2gKPcZv5whSArlvVPAE
 va1Mda82+F5qUdJC1j1uOuVjXAUBInQMf8RNTTBf9bJETgzWqLsDnJNRCxqTWaLWoDWx
 2Uwg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHzWptYbFWWkzm5nobSMaaKuDtCcHHyjJ8uowIyym/jw5h3XdZl9Prk5MEcTBF5a/V8N4+Mb1VvaE+nspq@lists.sourceforge.net
X-Gm-Message-State: AFuF++kYWm72xJNE/AQ0F02A2PQhzCdmZnJNddtHrNpLDA2jitsrAObm
 xlx1XNIpXHiGT6MiPaCs8XtfNApIz/XXEzvSzTfy4HmsBNaUh/chC2eTAXezsSZRyFVk+s5mec8
 diWuq07zj6Y+2FeO7fX0Ow3ZQsyRKlJG0sXHHMgQK/7nivoWeoykm/LAQdCHbHwXWiaRl
X-Gm-Gg: AYBFou0In4/rS2oCVh5hTHpD1oFd6EyERCO3knZ1fdpfyLr1O4B7dT1k4kuRBD/Z5Ra
 eywKA7q94d7gTJJwF7n52BULs2E2fH66o8aTVLRzeh7AzsM7JIxsbJzKqpeK2r/rWWEw07qDGcP
 bpPQ29VLfuQbbBH8WGQCC2BCz4nh//RMKFA/Hi/9gZwP0sGSDJgOrUWrc0JGgtQWZ9W+Jq6edkF
 6xC5dYfwHCM5FyLm28KowirvZAWyIeNxboUaBwt/zp+jkKuAPjOcoFqwjI1odjJvgBeOVvtB1QU
 g43/TWfdhMM9yHYHQDEM3nbE58vXEzYS1QyCAufNpC7AdtwWPfieuZVAtBWprcI/KaPfejiDPrT
 /oR+ayTgE02FmhjK7DnW0MF3IQb0y9Y1wZuVyd9W5G8rjOqKQ9UMP6k0MSp2aTyD2r7XeEwWTbx
 TbMwiT16VThd6j/BeazTnPEVz/3iEYxjUGuiVS3F5KSAouyN7AboeI0TfSNxK3lxtxqjBxwjVPl
 2FrlL2E0hDmfCifQBn9DTKmTuiCINVZiEW2ASUd3q8e8Z5m09WhUA9LLEPOZnzZrX9j/3p932Hi
 iS4ovy0yDT7XrKt++IBN77kGk1+8BCLyNT7DkCg8Q+e6FA8eDyU=
X-Received: by 2002:a05:600c:8b4c:b0:49b:12c2:104f with SMTP id
 5b1f17b1804b1-49cf5b5c014mr18889195e9.1.1788450155307; 
 Thu, 03 Sep 2026 08:42:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce47b9817sm120986685e9.1.2026.09.03.08.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 08:42:34 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 3 Sep 2026 15:42:32 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
X-Gerrit-Change-Number: 1734
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1734?usp=email>
X-Gerrit-Commit: 2902b94906e9b21e9288d9e43b24a3c6b5775e17
X-Gerrit-Comment-Date: Thu, 3 Sep 2026 15:42:32 +0000
In-Reply-To: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
References: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTQ1MzE0MDAwLkk3MjMwMjQwM2JkZGVlNGIwYjBlZTI0NDFhZTllMjQ2ZjQ4ZDBiYzgxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <01132e978d17979775fc83eafb3b6e87aa57209d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x29aM-0003Ll-6s
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Support pre-existing
 Linux DCO interfaces
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5606861752966596937=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5606861752966596937==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R82pibIvY9c="; charset=UTF-8

--R82pibIvY9c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

ordex has po=
sted comments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1734?usp=3Demail )

Change subject: Support pre-existing Linu=
x DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 1:

(1 comment)

File src/openvpn/dco_linux=2Ec:

http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1734/comment/68846f49_b680e078?usp=3Demail=
 :
PS1, Line 516:     else if (ret =3D=3D -EEXIST)
> The else branch is act=
ually needed because ret could also be 0 so this portion of the code has to=
 ex [=E2=80=A6]
I didn't mean to remove the else branch, but only the keywo=
rd "else", because the if branch ends with a return=2E



-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc=
81
Gerrit-Change-Number: 1734
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <r=
alf@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerri=
t-Comment-Date: Thu, 03 Sep 2026 15:42:32 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: No
Comment-In-Reply-To: ordex <antonio@mandelbit=2Ecom>
Com=
ment-In-Reply-To: ralf_lici <ralf@mandelbit=2Ecom>

--R82pibIvY9c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/dco_linux=2Ec:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1734/comment/68846f49_b680e078?usp=3Demail">Patch Set #1, Line 516:</=
a> <code style=3D"font-family:monospace,monospace">    else if (ret =3D=3D =
-EEXIST)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">The else branch is actually needed because r=
et could also be 0 so this portion of the code has to ex [=E2=80=A6]</block=
quote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">I didn&#39;t mean to remove the else branch, but only the keywor=
d &quot;else&quot;, because the if branch ends with a return=2E</p></li></u=
l></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1734?usp=3Demail">change 1734</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1734?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0b=
c81 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1734 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ral=
f@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Da=
te: Thu, 03 Sep 2026 15:42:32 +0000 </div>
<div style=3D"display:none"> Ger=
rit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels:=
 No </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;anto=
nio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Comment-In-Repl=
y-To: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--R82pibIvY9c=--


--===============5606861752966596937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5606861752966596937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5606861752966596937==--

