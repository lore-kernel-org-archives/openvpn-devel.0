Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921F8C5AD7B
	for <openvpn-devel@archiver.kernel.org>; Mon, 10 Aug 2026 12:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CJ9OmJgSYPrUTZcKkadnPZufloAvzYN40rtKq1/uOqE=; b=cjx6U+lbFB2tFAKbEsobNsi6CG
	u8eijHofT1MR+ea24QJ5dAuHXtMPxJ+3BG6gvBV7XW+FGwALFWWGNChos13al8bCDRFOWRL8CkpFt
	RdRHc+dukF6m0HsRaivJiNWX/wcqaLwvK1JKUJB55dwWpK7FrYW0+8FgGMYtlr4dV7eo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtP6M-0003oK-SZ;
	Mon, 10 Aug 2026 12:27:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtP6L-0003oB-Lh
 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 12:27:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=baz5EnwPS0SBk4HhyMpY9IqVUDODjlCQkWufPYLjEj8=; b=He+egaL6pKowo6OI4zCQTmesjZ
 4RXnOraCg6boF33bFgniyYynhreGv7WE/+OSFQHpsjGNSeQgMGOTitMdfoDmSIDKhrowAJ4enn4iE
 hAKHFs3R0OAfsZavp6WTjUFIBTXnruy8JvFPu4znZmekckAhLbd88nRrAxrcjoxpJwTs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=baz5EnwPS0SBk4HhyMpY9IqVUDODjlCQkWufPYLjEj8=; b=T
 VcFWexI47fV2nCZ0NOA7ABEvVfPuXrUYxUiVySDaorCZ+EColAEDgDiZRvCs25Vd1MF+D9gCG8eQJ
 JT0jRzJ0UthjDhxCndM2KGzfE56TK3A4puxikcL+tNZK4RexPdNS3d2GtepMyZ1HoA8ue5VqqXa+i
 0nYMhQC4erSSHY0U=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtP6G-0002wt-C1 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 12:27:31 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so9180215e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 10 Aug 2026 05:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786364842; x=1786969642; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=baz5EnwPS0SBk4HhyMpY9IqVUDODjlCQkWufPYLjEj8=;
 b=Zka7bzaI+gsTX1lKVQboRP/Woal9khHfkgECBF+UtrzWlRcMOLKa6vkLUz9rbq6vEB
 lm67LNcOHnBnXIQcuPIsuT6EfUe0gamBmAiWCGdvtwxSlsLR9JI3NZp1UsXR/n9YLZTu
 vXRF95rnJg8FPlZZ06Zstte+rdbSOEK3osG4L//GP3m5zUPGXDftrmO6ko2FnDGJNPMa
 +frl3GtlJQCO8rwxUxFng/R2e33AbWh6fE6F6Row7lHY+df3/7vazsWRDpnGvUQQevQv
 7+ozysb0MSCnggNyXi3s8kZp0svGD7zJnh3XYe2cujLX3/TfJre9u/oG8rt/ZIYdTyfC
 ZrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786364842; x=1786969642;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=baz5EnwPS0SBk4HhyMpY9IqVUDODjlCQkWufPYLjEj8=;
 b=BaHi/hu+cN+7AHBVaZqcfsS4N30h9fOAvszyZF4kqrRMpwfhifJZclT9jlX2HWzvd4
 LXBNn+en2hoRJ84a8oSBkKSD90pklTefSYIAssIlnmXdVzJnNKpVxXk6m+3pbyzPXnPf
 zjoxhL7aKJgqzFWlPfW2TmYDzig/RNgIgk3DZGwBghLgrEHABesY9ByhUUbXJQKwUlUW
 rVGfzFRj9R//K6NelmiJNXa5K7kQTFgbcRlCkU2GNnsk4K+TQU3u3QFt4tD/HyjroNuu
 q8iumMzIOi8kVBewYKEsb/v0uATXTSHzTLNITiEl97pRJzgjBp3CONrm6E0Y9P0DRIGl
 XKDg==
X-Gm-Message-State: AOJu0YxquYMGaoEjBoKgt/4h6/4eEjKnj/IAIzAA+yqZeIjGP21lw+Xl
 l6l6LfMFCmh0IJKE1g7nqfRYFo+ZiCU0ge2/wAuTCbf3BUE4ahPW+r/2D4UkDPP6p2fcJGtMZp5
 5q8pvv1401u41Y3AWONHejmHItuOXJOh2Us4GY+U3Z2Yqx9UNjhXqLgzx6vtG7bRa4Y/w
X-Gm-Gg: AR+sD10MVPezOCQ+gFawY5gM1Gtd7KCg9dprWH8Dx6+2iizXVgLDzU+rarC1XwrtQg0
 +bBFimcAZ80aa1Sx+PMkui5HhiRSeX0+JBpkMFBQW5sPN0d+kb8jNhLwQCfEToCc/vFQQV8n2IS
 I2YgXTfKLV8sLMBFji0HQHrDxjxDpgVrUc6f7r4DCj9doMqoMsn4q07A/wC/kvlorbptoWlomaG
 YHntiasvoViDLZwxYMGYB3rtXFOvd9DkQ1KSbuoQWE2LXNknXKsEiPrmqUMc65RnmvO0fMXUKfQ
 P27DwHzNCePF9gSaSJlB7mC08LdX4rIpVPloUg1vEmrZsFGYyR7xq3IwgX4mYds/Z6eEStKwikT
 MeG1ooX2Sr/d1l85eeQF7XARFEmlGW9wc7Nzlpv3GwW9T5i7cUy2utSCIOL/36Ln+LaX/3uvA5W
 s/bdrZi+JJDUV06n1mPwbDq2rn3PRGOs+pE0AOnBBMJuN37bHpLNHpIFrUDZjKdFexbE7EA9UG0
 iNCTprlAnnHYFR66noHDTrNPG2x9L1MQeU4IN3pXNbCQOk/6dV0QnCJAna8IxKFLnFuplalX4ZG
 JYesmQsg73NXlgnUx7yQfwGU3+6nYuIrgxUFHhaptWClbQGc/Mw=
X-Received: by 2002:a05:600c:c176:b0:499:7312:2d5f with SMTP id
 5b1f17b1804b1-49973122db5mr9257465e9.19.1786364841452; 
 Mon, 10 Aug 2026 05:27:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995c69c777sm305745255e9.2.2026.08.10.05.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 05:27:21 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 10 Aug 2026 12:27:19 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>, MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534
X-Gerrit-Change-Number: 1837
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1837?usp=email>
X-Gerrit-Commit: 603aa9698c140d15b7464af8fb83bd2aa71da680
In-Reply-To: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
References: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1OTMxNzkzMDAwLkk3MjgwNjdlZjA4NDgxYzg3YzdiNjkxOGM4OGViY2FlZWVjNDY2NTM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d900846208315a7e719be9f5fa716b8792e47355-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtP6G-0002wt-C1
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Reenable xmit_hold
 when using p2p tcp-server and tls-server
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2666106665060531579=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2666106665060531579==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7rACS8Z4MQo="; charset=UTF-8

--7rACS8Z4MQo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
MaxF


Change subject: Reenable xmit_hold when using p2p tcp-server and tls=
-server
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Reen=
able xmit_hold when using p2p tcp-server and tls-server

Commit 619c3e9 cha=
nged the logic to enable xmit_hold only
when c->mode is CM_CHILD_TCP=2E Thi=
s works for --mode server and
was probably done to allow to properly work w=
hen the server
is listening on multiple sockets and options->ce=2Eproto can=
not be used
to determine if this socket is tcp or udp=2E

Restore the logic=
 for p2p to avoid both sides starting sending
resets at the same time=2E

G=
ithub: closes OpenVPN/openvpn#1089
Change-Id: I728067ef08481c87c7b6918c88eb=
caeeec466534
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Max=
F <max@max-fillinger=2Enet>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1837
Message-Id: <20260810114212=2E28379-1-gert@greenie=2Emuc=2Ede>=

URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg38265=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
-=
--
M src/openvpn/init=2Ec
1 file changed, 1 insertion(+), 1 deletion(-)


 =
 git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/1837/5=


diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 69d226d=2E=
=2E08278fc2 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@=
 -3332,7 +3332,7 @@
 
     /* should we not xmit any packets until we get a=
n initial
      * response from client? */
-    if (to=2Eserver && c->mode =
=3D=3D CM_CHILD_TCP)
+    if (to=2Eserver && (c->mode =3D=3D CM_CHILD_TCP |=
| (c->mode =3D=3D CM_P2P && options->ce=2Eproto =3D=3D PROTO_TCP_SERVER)))
=
     {
         to=2Exmit_hold =3D true;
     }

-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534
Ge=
rrit-Change-Number: 1837
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: MaxF <max@max-fillinger=2Enet>
Gerri=
t-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>

--7rACS8Z4MQo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by MaxF</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Reenable xmit_hold when usin=
g p2p tcp-server and tls-server<br><br>Commit 619c3e9 changed the logic to =
enable xmit_hold only<br>when c-&gt;mode is CM_CHILD_TCP=2E This works for =
--mode server and<br>was probably done to allow to properly work when the s=
erver<br>is listening on multiple sockets and options-&gt;ce=2Eproto cannot=
 be used<br>to determine if this socket is tcp or udp=2E<br><br>Restore the=
 logic for p2p to avoid both sides starting sending<br>resets at the same t=
ime=2E<br><br>Github: closes OpenVPN/openvpn#1089<br>Change-Id: I728067ef08=
481c87c7b6918c88ebcaeeec466534<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2=
549=2Eorg&gt;<br>Acked-by: MaxF &lt;max@max-fillinger=2Enet&gt;<br>Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837<br>Message-Id: &lt;2026=
0810114212=2E28379-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38265=2Ehtml<br>S=
igned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/=
openvpn/init=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/37/1837/5</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/i=
nit=2Ec</span><br><span>index 69d226d=2E=2E08278fc2 100644</span><br><span>=
--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span=
><br><span>@@ -3332,7 +3332,7 @@</span><br><span> </span><br><span>     /* =
should we not xmit any packets until we get an initial</span><br><span>    =
  * response from client? */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (to=2Eserver &amp;&amp; c-&gt;mode =3D=3D CM_CHILD_TCP)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (to=2Eserver &amp;=
&amp; (c-&gt;mode =3D=3D CM_CHILD_TCP || (c-&gt;mode =3D=3D CM_P2P &amp;&am=
p; options-&gt;ce=2Eproto =3D=3D PROTO_TCP_SERVER)))</span><br><span>     {=
</span><br><span>         to=2Exmit_hold =3D true;</span><br><span>     }</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail">change 1837</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I728067ef08481c87c=
7b6918c88ebcaeeec466534 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1837 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;m=
ax@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--7rACS8Z4MQo=--


--===============2666106665060531579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2666106665060531579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2666106665060531579==--

