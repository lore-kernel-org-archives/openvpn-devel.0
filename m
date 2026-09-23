Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6C2C98304
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zlAgXQIiZgIxANavYsUx1H05BBPUUT4cNgp5+xTkUbc=; b=QOT4QghrLFsm3U7H2nDah2ii6X
	VEICAeQpexx1Cp+9ogKtR2+6fH1C/3mkFyAu58lg31UbMpyMfNGmCepNa649yZOPbsy6U1MbxRm0W
	0ahNEGJtwd1iwlfWlAv3KF1cZIlZxUUXicxeBIZxdA7WPgr3MUHqKbR8R2PBdeHVxsAc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9SJo-0004tt-Je;
	Wed, 23 Sep 2026 19:07:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9SJh-0004tj-0o
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 19:07:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=OErUbsQ/OV75NBZRT9D2wjxqacT0o1VYH4wXAdS5Zr8=; b=UV9n0Gzg9uoQhdqgUlIjSXUTRx
 YbFWuhW0MWixG3vidOjs7p+56e8WLxsMw1UTc3rCWMFrYkzsDzGXKhGXs7MK+CXZs54mCb+7rpHfq
 JSdEANH6OGETYZdkGXZp94ycKqdYf9RFty+HTdDvAmvwfadgkMpguUETbXlqMH0eYzdM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OErUbsQ/OV75NBZRT9D2wjxqacT0o1VYH4wXAdS5Zr8=; b=m
 BmvUw+WcNnUo9kv+87G08PK60dIjzWyG72qXVNwYJrZ0V5fj4YiPclIAKSd0wFIu7fjKHgptXtkm2
 kdTjR9WRajn3x1WNkRyQFE4E/ElZVmHQUrsk3og7uUGdRSa/ksNcbI4loxo98e+pYaTgBCBQOHWzM
 mMGx9f7qN0yUFQz4=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9SJd-0004hD-R4 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 19:07:40 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d3920so8710895e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 12:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790190451; x=1790795251; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OErUbsQ/OV75NBZRT9D2wjxqacT0o1VYH4wXAdS5Zr8=;
 b=b1K1yBDj3umw2MEGZrNN4m340wtqo+fwfvJfaA5f1TINFXxpb/MEQXuDl0lnH0Ddj1
 HvNiTdB5tPxTReHANtJImsJoo5yap9r7uuN9YxqKlVvnKS3m/gbsmbylayNzs1HHEsEM
 JinPXlQPD1AU5jiRXodVLwCTJn/sfIIj/A2MPMY8tfdt07p2Ogf/ktKpWIln572Ou0Rv
 OaTJ8j9zIY5vB2ZyPeuCpM83wvLL7Zh89wsH+goeSv0hHcaKbZ6g104w+6fw8AWst/bl
 3DJdPbwzPGZwhI6V5C5F0zumxpFlRAg0OXxzwQj3FQfP7odkZeViawqRRzWnT5TqfzEh
 ierw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790190451; x=1790795251;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OErUbsQ/OV75NBZRT9D2wjxqacT0o1VYH4wXAdS5Zr8=;
 b=k9r0JYOs6MneE9hy5XYahHZDCg7n6jE1J1prvaAUssn6js4t/OPbUlLjdiE5t49kR0
 ptagM5O4VQQd00VLHC5AeS6I8RjBt1GfDK/W6JOiyz9VnJXPIxH+b8gEPkGIxvfk4Muj
 Hk0vEJ7w9yYlMBtqr21FffvgDNmbY9Bcs4y2iua3fAvMR3lORQ3vVpWCllw/00mBlTGr
 IXM5IXAjGJ4lhIIMjjhJ/RHjPrCpg3LsXFGgpJslt2HfMpwOxdv1U+v9PEroL7k3JTaX
 VXiZvTKqm93hbAofT985xw6xVblZodm6yb98ynCSJRO5L8Tva1w2Pq/WxDuKLEqmXPlz
 fuGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzjexkplo/NZ/ov0i2Hg44t5wLQyqbXLO5mpo86TCYa34ClJseYmiKAc+hSnaSLMIaunCm3mzYFSU9qw3F@lists.sourceforge.net
X-Gm-Message-State: AFuF++nZGyKadblYZbKfKyaM8LH9Z44ypbTniLQv+DF/tLa/OPWV9EgH
 lggFKTtE40AiMnfCXpN0PaJmAO7jls1dz9GJ15yXj0vO6wPEZu4G88w4lECPM97gavHE8QJtW/S
 xw+GmUNzX24tG0cpWabR0ebxhb6tQTpuNbolLAlRd5alBFN69OBkbhjlZLDKtBuz9MSGiv+ABpX
 rjBYiVCQ==
X-Gm-Gg: AYBFou2E/04l8m/4+rHGP1niMij0rPpJrPkIJbHGypEk1j7VfbR7SyMMzAQ/iDHIr29
 0C+ZAY5tPdjGUbXHqNMx8SuLKoPkVT9/4IQA4LbvT8rY/reHOEu8YyiyBlkR3spLy+xGSRYyUvA
 yk5pu1wE6MkGNoFexlKIIfFq0xB5sIG169/iDioCd9Yta8pkL1vxmKVEeq9l0lEceCfB/PHLNFq
 WiMI8nj4OEKQGGzEAaOPufF6sGyQYZ/pDW4Ado7ESELyd2WUhGJx2VTa17V4CIH0tTTXwB1sICW
 c8Wjef+4uWcMfwzT2o9Kwd+K7wTDR0qV6tYazukTiw6+s7XsAUmQK+1SpC0LWTfVb53Amjl3Zuz
 s7Rt9///KG6fCCMbFvCjG3j7r8BMdYe1ssy+09dQ3BaYvQIXPlG8PpKkc77KuW6znL05rUkj2RH
 Ef+SHMUa0MecG9UgEMCci2S9Iq2LXeTtgNy5qVfPFbOvUuy4/uoxcwGJh2kz58crMZdccYCcRvm
 L3j4NBvxqZG7YDixq82LwLO9zLrs3l8ZkSTRQMMsd7ZUbM9jxn3y/Ej3uH+feVGXLrcJeH7VMLR
 oxrFrUvHeNibd0pFT5i3gNboTZHX3ZzxRsAAGR81/BrLn06o7Pw++jBUOzTB
X-Received: by 2002:a05:600c:4754:b0:49c:c96a:d36b with SMTP id
 5b1f17b1804b1-49fe66d1663mr2738185e9.12.1790190451148; 
 Wed, 23 Sep 2026 12:07:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd4d12sm6675585e9.4.2026.09.23.12.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 12:07:30 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 19:07:28 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
X-Gerrit-Change-Number: 890
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/890?usp=email>
X-Gerrit-Commit: e064870a823d64266e703fb724cb088f366f593f
X-Gerrit-Comment-Date: Wed, 23 Sep 2026 19:07:28 +0000
In-Reply-To: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
References: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzM5MzYxMjA0MDAwLkkyMmU0YjczZTc0NGM3NjVhNDNiZGIyOWY2ZTE4ODEzZDEwM2VhNzU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3f251aca50f74b923ac289acdbcebea86a56211e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9SJd-0004hD-R4
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Always use a
 0.0.0.0/0 default on Android instead of def1
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
 gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5952240204477587239=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5952240204477587239==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Hk1LjSHOztc="; charset=UTF-8

--Hk1LjSHOztc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos=2E

ra=
zvanc has posted comments on this change by plaisthos=2E ( http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/890?usp=3Demail )

Change subject: Always use a 0=
=2E0=2E0=2E0/0 default on Android instead of def1
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review-1

(1 comme=
nt)

Patchset:

PS3: 
I've tried to follow what this does for a while, and =
I'm not convinced the change doesn't have unintended secondary effects on A=
ndroid=2E

In route=2Ec, `undo_redirect_default_route_to_vpn()` used to jus=
t `del_route3()` on the `RG_DEF1` `if` branch=2E

Now, if `RGI_ADDR_DEFINED=
`, it will also `add_route3()`=2E On Android, `get_default_gateway()` sets =
`RGI_ADDR_DEFINED` (and `gateway=2Eaddr` to `127 << 24 | 'd' << 16 | 'g' <<=
 8 | 'w'` for some reason)=2E

We probably don't want that=2E

Maybe I'm mi=
sunderstanding something?



-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/890?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
Gerrit-Change-Number: 890
G=
errit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <g=
ert@greenie=2Emuc=2Ede>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Wed, 23 Sep 2026 19:07:28 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: Yes

--Hk1LjSHOztc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos=2E </p>
<p>razvanc has=
 posted comments on this change by plaisthos=2E</p><p>Patch set 3:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?tab=3Dcom=
ments&amp;usp=3Demail">Patch Set #3:</a> </p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">I&#39;ve tried to follow what=
 this does for a while, and I&#39;m not convinced the change doesn&#39;t ha=
ve unintended secondary effects on Android=2E</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">In route=2Ec, `undo_redi=
rect_default_route_to_vpn()` used to just `del_route3()` on the `RG_DEF1` `=
if` branch=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Now, if `RGI_ADDR_DEFINED`, it will also `add_route3()`=
=2E On Android, `get_default_gateway()` sets `RGI_ADDR_DEFINED` (and `gatew=
ay=2Eaddr` to `127 &lt;&lt; 24 | &#39;d&#39; &lt;&lt; 16 | &#39;g&#39; &lt;=
&lt; 8 | &#39;w&#39;` for some reason)=2E</p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">We probably don&#39;t want th=
at=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Maybe I&#39;m misunderstanding something?</p></li></ul></li></ul>=
<p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?=
usp=3Demail">change 890</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/890?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 890 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Comment-Date: Wed, 23 Sep 2026 19:07:28 +0000 </div>
<d=
iv style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Hk1LjSHOztc=--


--===============5952240204477587239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5952240204477587239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5952240204477587239==--

