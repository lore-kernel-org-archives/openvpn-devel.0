Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1416606A322
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=T7IKQQyV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EUWq02HU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mqovc9ak;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZX7BM8pQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ql3Gwxd3taNBK+M8quJ+mpBNuGJzb7z3hWZVmjNAx60=; b=T7IKQQyV7dF6qTquzOrw/kJEt+
	Z/fg8IJCIbuIs4DyIo7gZZ2JiE+H5PxB+GWVoLiNSJTCYGqPCYJ+YI1TmbAMJ3t3Iax+JmHHnTxJt
	c6kVkAokgTkCsOjCkmyvri6+Vyjh2b6cIT8ZxRIEXluh1gBcp79DwM/n/gQLiJi0sZF8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQO8m-000000003mk-2ChP;
	Mon, 09 Nov 2026 12:06:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQO8l-000000003mX-0PMy
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 12:06:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nR+4CTyoGidhTXa5XzQoWM5b+/Oa0mmQy0AP6w+F0S4=; b=EUWq02HUkX535uwqpBC3u5upbF
 eJtpBPV1X2E1+5TNOjRtEXgZJeEqwvCI/Sh+lolypvfWfncK4QymlR3/ytHMg+wuARdIogrI/UkJr
 C3cOuJLsdlZVtPQpMNmksMRZX0TNFgYYCnSWxXciSjYt1+yfroAo3bkAndsAOBK9aYEE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nR+4CTyoGidhTXa5XzQoWM5b+/Oa0mmQy0AP6w+F0S4=; b=mqovc9akVmmUNow+ib18/odLsu
 lwhRHUBYC9sivXdyJfdoLm4KElliJ/n84oRfSw0aR/KgMznsAX9z2CvT7023DFYfCxoqlb6ikxOnX
 GX5Nxbsp9EYtoZZR4tQ0XoQCYE3sw0MPy5DqhXorLwPd5jyN/ZWwHi7aeqRbGxzmmp7I=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQO8j-000000004I4-1jPq for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 12:06:23 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso498796f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 04:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794225975; x=1794830775; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nR+4CTyoGidhTXa5XzQoWM5b+/Oa0mmQy0AP6w+F0S4=;
 b=ZX7BM8pQ0Ga1OMHZyLNETMaTkc0/25xLGX8eO6r99sHO95tJAgPQkIb55Wbq2hkUsO
 ytXrd8+bjc+0ijJqMSCAQQnaLJ6UYTq77FZrf3p0unQKyvi/J5nPp6c78yn8k7QAxG4Z
 MfG4lroxY91byD6IWuTgFNKliboSnDRwEil6AhPwaIHptLxhxv80vhENfHNyJhmVZHN7
 22/XuJYcyuUDDrOJqNPlanObCxEEaf8QLycxiInaqjbH2CVIS36q6g4dQsiH8gmJgeMT
 8xoPprfjYYrdsGzwBt2NPnaZ7wKBvQDH+siUh8Jr89PrKpKbJNQW7ubr5AyN6QRMZmcw
 ifoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794225975; x=1794830775;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nR+4CTyoGidhTXa5XzQoWM5b+/Oa0mmQy0AP6w+F0S4=;
 b=FKc0sQ7e7nfMbZEfOjYtvGkBGDvMNNsnCFo+35HuiAepQyhI85Dkbu+5MdZ/ueVd6B
 R4IfgbuN193pQoZ2dhGezxE3ciQCxmLJjK4YfcsHjCi/Kc707caMDLaufy7q9m/tzdZS
 8dgaMO2VT7R+EmyJeAE2VtGXyCIYuKh1oPqzyD+24Knuad1562kLR1MI1jBfSskdjVRU
 5fz/OZU5+LJECxijCp3CupXWRPor5SCtBvASPFf8TQaUl9N/tDS7I5cp69E0f1nTGoN9
 mEGu9rzpYJuWF87Xj35SYsJArAiYtBDexchL/Y3WDqaLzCjTWvZwUYB63erLRQr6Rqd/
 +0uA==
X-Gm-Message-State: APuU4Z/U6HTXM12CROtitssYbiOMqDBoF6vejZoipHC+E4RRG+ODRQ7Y
 rs0UzF9I0iuuLQjR8HYa9FzMDGrKclU+PixOyW5CCAeHIRVTt+AnNgfs9TdfMeKBbEMBl0gO80p
 cLoSEVvfYm4vyAhS99r7I6YX6zMLfgBp6MLwTNW39V+6KEGMTAaHxbkx/9lk95yCtzCb0
X-Gm-Gg: AYBFou3ZkAja8UeG6arnyGziY9H7Gc7kH8uDOI6GAJ8T9d4JTRgL0UNMFAP0DrR8cxX
 +0ODVMVlqVGuFxqJd2Y76oXouK1bqte4o8eUHEoTMaSQH4jmwwSlDoxDxvkGcTkXJ0iPPmLsKhs
 MxEouqbZnhZZbDcdFzxpWfCOa5tNurlQX9JOZjADVctTHuKZ1uWi8PrtTX/XAngqQczrqQ2FjFE
 nENapjQaRGl4eXGKHNXKA+b99mGMosPc0uVCvA/FUEmPi+L7zViwLKwrqnKH9JlNMd3Qfp2hEJ9
 D5OzEfNWURmrZ+CPVDAz8PaaUg0NpY4tzWLBY5S014s4lVyGR7P4B5S+p0UbYg3tXg2rrC7BAgq
 gWFOyUUzjaiF6JqFX3G7Dkln9BTFSqadvRAQ90xKh0WN/z8lLR/UuvHeDWPs+OznQsoIMH/ET3N
 bK4AYFHc99p711u7D1vgUvN+U+Qk64L7u3k1yy60PuchoYTNVSlJdcA/BYnW3zasBStx3pBotga
 9yYGUmMnlbS2N6z0lk8COn5G3TKSohZ8bYTqmI0Qzi5zwIBJYVjzY37jkoowy7tv50uYYU2XYuD
 rEyUiFHbwSNE09IFs4+MlUGxIZQJl0RK0fYfMAlarX9BwaCQw0PwwnrioiYsm3QY8tjwi2neYAY
 dJ8/Wdqqd2OJiJDRvaZpVCXGPF5jaxEQ1DsDmEJ+CK0FBl+YR7uNR0kh8ymKp8BcKmlDz5SMHFa
 GfRtoL/UtZ/QUL0N8HQix8R1MhICZprpNrmhI=
X-Received: by 2002:a5d:64e9:0:b0:48e:5e63:bd23 with SMTP id
 ffacd0b85a97d-4958ac94f75mr8346124f8f.30.1794225974509; 
 Mon, 09 Nov 2026 04:06:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597090444sm10128795f8f.31.2026.11.09.04.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 04:06:14 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 12:06:12 +0000
To: Lev Stipakov <lstipakov@gmail.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ied9e36d45b30a88610cafee668ecefa98b29eddc
X-Gerrit-Change-Number: 2146
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2146?usp=email>
X-Gerrit-Commit: 672f39fbd0a88ce0b387d581da22a7b5d30b91d1
In-Reply-To: <gerrit.1793970201000.Ied9e36d45b30a88610cafee668ecefa98b29eddc@gerrit.openvpn.net>
References: <gerrit.1793970201000.Ied9e36d45b30a88610cafee668ecefa98b29eddc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTcwMjAxMDAwLkllZDllMzZkNDViMzBhODg2MTBjYWZlZTY2OGVjZWZhOThiMjllZGRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <be8cf5f26cac534ddbca87fba9e82ac625309803-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQO8j-000000004I4-1jPq
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: reflect_filter:
 initialise warning_displayed in the rate limiter
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5528836758950533592=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5528836758950533592==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YGnijAL97nU="; charset=UTF-8

--YGnijAL97nU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Lev Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2146?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by R=C4=83zvan Cojocaru


Change subject: reflect_filter: initialis=
e warning_displayed in the rate limiter
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

reflect_filter: initialise warning_displayed i=
n the rate limiter

initial_rate_limit_init() allocates with ALLOC_OBJ, whi=
ch does not
clear, and assigns every field but warning_displayed=2E The fir=
st period
reset assigns it before anything reads it, so nothing misbehaves =
today,
but there is no reason to leave a field undefined=2E

Change-Id: Ied=
9e36d45b30a88610cafee668ecefa98b29eddc
Signed-off-by: Lev Stipakov <lev@ope=
nvpn=2Enet>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2146
Message-Id: <20261109091139=
=2E4816-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/op=
envpn-devel@lists=2Esourceforge=2Enet/msg40963=2Ehtml
Signed-off-by: Gert D=
oering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/reflect_filter=2Ec
1 fil=
e changed, 1 insertion(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/46/2146/3

diff --git a/src/openvpn/ref=
lect_filter=2Ec b/src/openvpn/reflect_filter=2Ec
index e5226e4=2E=2E953fff5=
 100644
--- a/src/openvpn/reflect_filter=2Ec
+++ b/src/openvpn/reflect_filt=
er=2Ec
@@ -95,6 +95,7 @@
     irl->period_length =3D period_length;
     ir=
l->curr_period_counter =3D 0;
     irl->last_period_reset =3D 0;
+    irl->=
warning_displayed =3D false;
 
     return irl;
 }

-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2146?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: Ied9e36d45b30a88610cafee668ecefa98b29ed=
dc
Gerrit-Change-Number: 2146
Gerrit-PatchSet: 3
Gerrit-Owner: Lev Stipakov=
 <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--YGnijAL97nU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Lev =
Stipakov=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/214=
6?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ref=
lect_filter: initialise warning_displayed in the rate limiter<br><br>initia=
l_rate_limit_init() allocates with ALLOC_OBJ, which does not<br>clear, and =
assigns every field but warning_displayed=2E The first period<br>reset assi=
gns it before anything reads it, so nothing misbehaves today,<br>but there =
is no reason to leave a field undefined=2E<br><br>Change-Id: Ied9e36d45b30a=
88610cafee668ecefa98b29eddc<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=
=2Enet&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2146<br>Message-Id: &l=
t;20261109091139=2E4816-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40963=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/reflect_filter=2Ec<br>1 file changed, 1 insertion(+), 0 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/46/2146/3</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/reflec=
t_filter=2Ec b/src/openvpn/reflect_filter=2Ec</span><br><span>index e5226e4=
=2E=2E953fff5 100644</span><br><span>--- a/src/openvpn/reflect_filter=2Ec</=
span><br><span>+++ b/src/openvpn/reflect_filter=2Ec</span><br><span>@@ -95,=
6 +95,7 @@</span><br><span>     irl-&gt;period_length =3D period_length;</s=
pan><br><span>     irl-&gt;curr_period_counter =3D 0;</span><br><span>     =
irl-&gt;last_period_reset =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    irl-&gt;warning_displayed =3D false;</span><br><span> </sp=
an><br><span>     return irl;</span><br><span> }</span><br></pre><p>To view=
, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2146?usp=3Dem=
ail">change 2146</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2146?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: Ied9e36d45b30a88610cafee668ecefa98b29eddc </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 2146 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body><=
/html>
--YGnijAL97nU=--


--===============5528836758950533592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5528836758950533592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5528836758950533592==--

