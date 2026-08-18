Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4C4C5DF70
	for <openvpn-devel@archiver.kernel.org>; Tue, 18 Aug 2026 06:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jiTnh3VvIZcbwg4hc4WLCU6rKqeCA50ATz/q3gn0OO4=; b=OSfDO8jYE9wJlImUU/EURzqSol
	kpp9TfokH6hzLC5qsLMkdqIzOVLR/6plLlgwRvmAQN0MjA4iiNwdi0ehmt/pEr+gHVFSQGNd28hNR
	vagmYR33zPnnw9l/K9qUKF4Rd3OXZlHgHk4prJzJ4AYywD/sHhxufOVL77nbxdWtchbw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwDMv-0000o8-AO;
	Tue, 18 Aug 2026 06:32:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwDMd-0000nd-C2
 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 06:32:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=bc9L9uMlP1BJQ02hXUqBGv1AV9FxpzfTGLAMAgsGGZ0=; b=YEd9Jwt0vmHdcAAsPmKGk6mgud
 E1r2d/hfES/96AClyZNvPYilLqjArvkcVzlLxOntpa4k0DEPvZjIaAxWERq3PkCPfH5DgUeZZ37+j
 uu3QephSimU5a1QVMb5J9wxCZZOCGt5Angzi7mmk31tOjfZX9fQwx6qqok4gIDsXOq/A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bc9L9uMlP1BJQ02hXUqBGv1AV9FxpzfTGLAMAgsGGZ0=; b=C
 njtNYbSSL53m9s5YRQmFWJEFeKjcKTaaacf05pGcSCZRJzTCwuDHpLhiYR0MHtfOHwvb8irG8aMu8
 iQYdkUE7Zz38YGz7ssToYG+gkXch3TvUhhpc6H+4aPEtI6FvMUWAeHgX8Fe9lPyJpNalc9dYocXvH
 UD3rmXMsC2nvfMxE=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwDMW-0006g9-EU for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 06:31:53 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47fe89fb333so2568728f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 23:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787034706; x=1787639506; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bc9L9uMlP1BJQ02hXUqBGv1AV9FxpzfTGLAMAgsGGZ0=;
 b=D536B/EFq7n9UKZREVbx/ILKh+5mUcEBLZLCUshMChq8+g3V2J9KXgx2Oht0FBqkGw
 iFXvskB3ZOPvFt8stLftAiEk2hgS1dTlzaqPGIXhKxvjC4rJHp1XyAztjT4xBXzye8Z7
 +GWoAOawwAcUzwyaQXQAi0VIO7a2au0Dl7lCQTBgi9+HuOq0tpYe8TAMH3vGvhulX87z
 379AdDogpb2jcyn7v5jsRSzAu4UfGG71Mz3mZlxVlWbGnH0KfOLx4AkHshJ1ua7EB0HL
 CNFzqM08Ydruf++wF8sOePH8urOVQzAKqmxf8ZD/uCjXUy2/g5185K53lbi350UFMCZ5
 zCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787034706; x=1787639506;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bc9L9uMlP1BJQ02hXUqBGv1AV9FxpzfTGLAMAgsGGZ0=;
 b=O7BDpcDPgAbTF5UmVMQqswWpXKgHV97csdKBR+Haqcpdh0CBGChuIYy9wirFJE+/8o
 bYf3o43GJFUcCa8c4BDjts9gPo1TxBDc6giRLmZTLJtS8e6MtEPxbR9YgfCZT91hQMMx
 dtG4oIsSa2N6lO5GFVEsb4DxSPVMmeTpRfj68v/SVeQga8CdZGwirT/T5FI3MF4/T3CT
 AEwVbqq4OQhJ9K4ncQY1oG2JeX5n7cAdJEaJC4J5DvvMMC2FGdM2PD17YrjoX5mOH1HA
 FYjD9cblRkmS+gseWFi6L3rtKEYBfoelMZBkP5zQJNftlpS6R1D2TIvtkA0xzwDQoQUu
 IHAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYoUt5OxT/EN33u3gbJ5BKJhJG8TNL7ULqw1Fhx+6wWDDUQjBQPXpZ+jtqhQYdzP9K3DuckxC/X1YkumS9@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx+jkYI6ny67wV0/NvA4hNELCcdBybh2o+9mcXAyId6NOBmqJgg
 LqBfuNaa7OQ05ys/5/TxBxcpjhgDLGX8Ob6h+ZrvLP5fmvex2moro3t1cAS54GIVXuxETkrz4zk
 TDQfz7aFyJGBnW0Y0cbJGNpjzblqIdJtbm43RG/wFdpb3iZCjgOcIuC8apO6OOnRrAVEBqjAidf
 Vp68BA2Q==
X-Gm-Gg: AR+sD13e3YhplBFLN+MpKYozqIZAv9m7yLXf4j9N+e2QXROe1tpdiO7dupxjM0uU3aQ
 qluNtqJwPrkCeMfZDjofBNk0g8DTrJQkY17WDJSjZQ1Gol50SGSM4XFEuWTFVbruhvZ0TqCs712
 sZmozax/OPyc9n1LjYp1K1PmZI0Tj5hE+bznrnQojCgUqNNur+yRFqyIR5yHBuVMXtH0KauriQa
 7135ZhloaEM4Voc5yVkptROYI5+1iJuOT4Z5rsWosN4aDKQ+kOc1xo6TKj7wJcEpXSto32po6OA
 pvZ0uuFKVIsASBNXsMKuvPVJDUklia4b2+kMmuHZF0hoo/msQPE+nCq/yMEsdPvlRAhYq7anGoD
 IYD+397NeGzn2Y7SJyZEk848+Z59Bh+yP21BZKClUp9mF3Vvik+Uckd8wTiDyWYOHHHEBTi4qQs
 JC+zhn9ksrDe5Z9WEMrE6zvO/zkZKXaChgoebD0KNt9lylSTpgkYBZRe4tu7ftnAoqvYVYz9Dya
 kg/iAzUxZVHw70T8C1R4J4M0V3RI0gTxx05dJ99b2ZdnP5XjnMIKb0bxyTyrJwAZlD0Bj1t+W1J
 dnc5h22PmlVqJyMX4TnnGzR4WeO8JrTEX9mYTghigsUQGAUAfc2D53W7BBa8M00=
X-Received: by 2002:a05:6000:41c2:b0:481:4697:a6b0 with SMTP id
 ffacd0b85a97d-482a90dde4amr9774445f8f.20.1787034705778; 
 Mon, 17 Aug 2026 23:31:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a7c568sm9485359f8f.18.2026.08.17.23.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 23:31:45 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 18 Aug 2026 06:31:43 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f
X-Gerrit-Change-Number: 1793
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1793?usp=email>
X-Gerrit-Commit: d6338dda35d34883f1adeb1dd8c1e4e1686397b8
X-Gerrit-Comment-Date: Tue, 18 Aug 2026 06:31:43 +0000
In-Reply-To: <gerrit.1784305303000.I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f@gerrit.openvpn.net>
References: <gerrit.1784305303000.I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLkk3NmNkMzhmYzRmNDNjMmI3NWVkNGNhNmI5YTVjOWZmZGJmMzMyYTBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4a018c027ba2ffaa6776cd8241e3d844889a7072-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwDMW-0006g9-EU
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Reformat all
 shell-scripts with shfmt
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0411050260560981748=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0411050260560981748==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lAX8+l5GgTk="; charset=UTF-8

--lAX8+l5GgTk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1793?usp=3Demail )

Change subject: Reformat all shel=
l-scripts with shfmt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 2:

(1 comment)

File dev-tools/gen-release-tarballs=2Es=
h:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793/comment/5c92132b_f4bb593=
4?usp=3Demail :
PS2, Line 72:     res=3D"$(find =2E -maxdepth 1 -type f -na=
me \"$wildcard\" | head -n1 | cut -d/ -f2-)"
This doesn't have the same mea=
ning as before=2E Within backticks slashes get stripped, but within `$()` t=
hey don't, so now `\"` will match a quote=2E

You can test with `"openvpn-2=
=2E7=2E0=2Etar=2Egz"` (quotes included)=2E



-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f
Gerrit-Ch=
ange-Number: 1793
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lich=
tenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: r=
azvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Comment-Date: Tue, 18 Aug 2026 06:31:43 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: No

--lAX8+l5GgTk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File dev-tools/gen-release-tarballs=2Esh:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1793/comment/5c92132b_f4bb5934?usp=3Demail">Patch Set #2=
, Line 72:</a> <code style=3D"font-family:monospace,monospace">    res=3D&q=
uot;$(find =2E -maxdepth 1 -type f -name \&quot;$wildcard\&quot; | head -n1=
 | cut -d/ -f2-)&quot;</code></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">This doesn&#39;t have the same meaning as=
 before=2E Within backticks slashes get stripped, but within `$()` they don=
&#39;t, so now `\&quot;` will match a quote=2E</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">You can test with `&quot=
;openvpn-2=2E7=2E0=2Etar=2Egz&quot;` (quotes included)=2E</p></li></ul></li=
></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1793?usp=3Demail">change 1793</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1793?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1793 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Tue, 18 Aug 2026 06:31:43 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labe=
ls: No </div>

</body></html>
--lAX8+l5GgTk=--


--===============0411050260560981748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0411050260560981748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0411050260560981748==--

