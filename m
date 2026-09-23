Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437A0C98304
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dVeIw7OwAkW5zdw+MOu0vy8PSY5688xlBpagB9lBDqw=; b=BMrE48Vwi9xO/L98Gv3kdvUc40
	/pV3t6Yq5joJJb2Bre/HRxARnX9Z/CXtraLkHOcIVErwnaMziO5mksjaxDlqVHb0OjHdCFfXrDxYS
	aksVX6RTglNy4T5UWj0CQ+Zhb2333r79mxASQzB5gTNBeyPWD4twRijVftC7+4me3e0c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9Nyo-00039M-FC;
	Wed, 23 Sep 2026 14:29:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9Nym-000399-Nc
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 14:29:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YeozUbO3qffZ2kXu7jSUoVO31ixemd24WpfUJC13CZQ=; b=fY8+eK53Ovy616YIgxlpn9xOEh
 T5uQow7FayTE9yuEc1VQZGnU29xchdT7g29OOgcJyXdXPpD3uyzc0YlyO2yr+v5vx5Z3HivPf4Yoh
 s9U5dYjVrs7Ug1Lf40nq/zRAOrl/vTETEa8kC66Vpvj3r9WgWwjNuOP0UcbEyKUWd+Qc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YeozUbO3qffZ2kXu7jSUoVO31ixemd24WpfUJC13CZQ=; b=M
 WcbtrAzM66SM5BYDaaV6pID77TAkKezhTHsA/DCUxrSDrqvB/uoJet2tIr/jOlR7lsphYCzP4rhv6
 2bU6sRbaJyog47hrAHS2i5l7T6qhcCvS7F0fDI6gksu7/XhF67eP6k5gL1tOf+VT8jVM1mQNOBs/N
 Ee4EkxzS0OJimzHo=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9Nym-0003Pb-CN for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 14:29:49 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d1ca5b0d6so6928875e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790173782; x=1790778582; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YeozUbO3qffZ2kXu7jSUoVO31ixemd24WpfUJC13CZQ=;
 b=eOzW1W+18Uf57fc01Q9lHHtsDo8xHoXsmTsUj4PenmSiriLdKmM0Br9a9FDxRIIUiw
 6B/yOaDOXCxasQm5lrRGMSMqn0dgfAg8vGLITuTpPlCe+EpRsegnN76tY/P4pKAdHZ8B
 qoC3KzK5iPGVyASDAA7+5MOhJl+vAl5j3iEbKZUA7LNgFiwmjXx9NufGphYBVCUiZk3b
 MEO6K+8veWVhWsIdpqLhGVfcb1ngeUtKSPDa26HGWSEXVGS0o96vaN8e3fjKjnMQrEX/
 jjeR0tlWmAKEy6Yt4WcicdIhL+LKdRGi7mXKdTNIYFcT9hLV84McydzGycVgKKVMWwb5
 b4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790173782; x=1790778582;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YeozUbO3qffZ2kXu7jSUoVO31ixemd24WpfUJC13CZQ=;
 b=ma1xGv+nSE9omzA2NU8YbfrSqjEjZs9PzkGt0ycnkVvuMgfhO+313Kr5XZTl76W+x+
 oDPf7/WdlatdazvdHV3uFU5sw7xpVR/VU4xJvEKIaUFmcMLsBBzwkebXtNVRJ4M45MWh
 GlgQBDDAVd/E/6v9xG4EU0xAbBepGtRVwzRgP+nJ6QyLs1Phj9dQ5JSU2me2q/BwHsP/
 JfiyP43xjVtNdzBB8haAaybcBGMSrkwz7kFIHYEslcDtWK45zQWPLx8GOdYvE0tnC4e8
 VHBW8dJmoPAMzzMIHTrod8WDqockU+/9qgic0luCkjohvQ8So5lqdE5abeaek60BGiHK
 bLig==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwaO8bc4Y+zDtgeduzIQZobfuEPnEeuV2fGpv7hVjF3B4v1ws0z+CZyTwMM4NhS9p834Gp3cGushSfuVmx@lists.sourceforge.net
X-Gm-Message-State: AFuF++nXOhWB0IQtqFgy37PqixzOBe49Pb4ohk3G4HlU3Qgif6kSWPBt
 K7RbkoBL9rYFDZpkbHYbCjHp/Gm9sUSpGZFywtwqLXh55qyFIJCs3zf9DN0lqe6u6crGuyx6sGY
 tMxr9HVTOU826wtwYCR4rhDc4GvhMmWABO9CcdnTtU/o4EEPiWXpHDKX73yXLuy1KELLd
X-Gm-Gg: AYBFou01vwZ3zJsuvTBSoUN3Z46AWDwwu0ldxTROv7nEp0ky5tKEZjeiI/JwC5gvCEc
 mg3Uofg7lOFciyCRcFQ9ErEkku2LPwaWwla38HXfgDROQ/hPdRTTp30cU32s9FLNBcDvFRaGkVK
 KgJisXMVoekZZ5qL8iXOuzzIbU288uvPeIogjDkqe8Olmblwg+rV6oUWfP18iA14kPVGdJmJkEC
 81W8WESYOUfW9v/vM/D3F9DL5/8d1MoWJ9AmENxSQ661gkchbvUg38R+IDpcKW2NlPiDQJO3oUQ
 bhijUFlL3vN+8j18h+02Qq+5srWjo+vxqMmbz/dMQ7QeMUAEtw+a3hVRxFnmLs7hZcDjYdYkMpn
 PgWG95yxGTq2sT4y7jK//Dpzrgf8ITJi/7xuyFbbrYrljGnLGfdyXSI7deuUkzH+MML+MsWDRux
 kfGJpO06zrfP59DZnEBX/73bisrmIJ1Q3Ld2tq/HG20eK+/Y0D8yRpouxKFni5ZLGXUmDZlrF4E
 wNOfNNxDsIw0V+lxCT1HtMPvIIaFnZQlDhCnrcxTLrcDhPKGnyWLfcahAspFH4JwKpipxxai1Za
 2Zb1VUOYbhH1n4J/XYnBWt9iNCVINxO1ulVCrp+01gsXhIUdK+qcXrUJPv7BbtWqlOyamTV7
X-Received: by 2002:a05:600c:3b92:b0:49f:c432:2e50 with SMTP id
 5b1f17b1804b1-49fdf1399d7mr48367825e9.25.1790173781636; 
 Wed, 23 Sep 2026 07:29:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886876c1fdsm8395476f8f.14.2026.09.23.07.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 07:29:40 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 14:29:38 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 25
X-Gerrit-Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755
X-Gerrit-Change-Number: 1769
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1769?usp=email>
X-Gerrit-Commit: 153952333cf2562dce3068ee107369a9672f12b7
X-Gerrit-Comment-Date: Wed, 23 Sep 2026 14:29:38 +0000
In-Reply-To: <gerrit.1783320647000.Iec384ee6844ab278b280d6eafec8aaecf9dde755@gerrit.openvpn.net>
References: <gerrit.1783320647000.Iec384ee6844ab278b280d6eafec8aaecf9dde755@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkllYzM4NGVlNjg0NGFiMjc4YjI4MGQ2ZWFmZWM4YWFlY2Y5ZGRlNzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bea94554f6d640bff9239d847896b30a9e9551bb-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9Nym-0003Pb-CN
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: adopt a
 pre-created UDP socket for a client connection
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
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0663217566719900468=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0663217566719900468==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GGURPObAC/U="; charset=UTF-8

--GGURPObAC/U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1769?usp=3Demail )

Change subject: socket: adopt a pre-created U=
DP socket for a client connection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 25: Code-Review-1

(1 comment)

File src/=
openvpn/socket=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1769/comment=
/49c45e3c_a6d4ee11?usp=3Demail :
PS25, Line 1449:         sock->info=2Elsa-=
>actual=2Edest =3D c->c2=2Eoob_probe_remote;
I find `actual`, `remote_list`=
 and and `current_remote` quite confusing so I hope I'm following this corr=
ectly=2E

Here we pin `lsa->actual` but later in the same function we call =
`resolve_remote`=2E So suppose the probe resolves and selects address A, wh=
ile the later `resolve_remote` lookup returns only B=2E Outgoing packets us=
e the pinned `actual` A, but `link_socket_verify_incoming_addr` validates r=
eplies against `remote_list` containing B, not against `actual`, so the rep=
ly from A is rejected=2E

This might not be so unlikely in case of round-ro=
bin DNS=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1769?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comme=
nt
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iec384ee=
6844ab278b280d6eafec8aaecf9dde755
Gerrit-Change-Number: 1769
Gerrit-PatchSe=
t: 25
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attention: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 23 Sep 2026 14:29:3=
8 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--GGURPObAC/U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>ralf_lici has posted comm=
ents on this change by stipa=2E</p><p>Patch set 25:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1769?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/socket=2Ec:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1769/com=
ment/49c45e3c_a6d4ee11?usp=3Demail">Patch Set #25, Line 1449:</a> <code sty=
le=3D"font-family:monospace,monospace">        sock-&gt;info=2Elsa-&gt;actu=
al=2Edest =3D c-&gt;c2=2Eoob_probe_remote;</code></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">I find `actual`, `rem=
ote_list` and and `current_remote` quite confusing so I hope I&#39;m follow=
ing this correctly=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Here we pin `lsa-&gt;actual` but later in the sam=
e function we call `resolve_remote`=2E So suppose the probe resolves and se=
lects address A, while the later `resolve_remote` lookup returns only B=2E =
Outgoing packets use the pinned `actual` A, but `link_socket_verify_incomin=
g_addr` validates replies against `remote_list` containing B, not against `=
actual`, so the reply from A is rejected=2E</p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">This might not be so unlike=
ly in case of round-robin DNS=2E</p></li></ul></li></ul><p>To view, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1769?usp=3Demail">chang=
e 1769</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1769?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1769 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 25 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt=
;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Comment-Date: Wed, 23 Sep 2026 14:29:38 +0=
000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--GGURPObAC/U=--


--===============0663217566719900468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0663217566719900468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0663217566719900468==--

