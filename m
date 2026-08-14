Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D82C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FPKPRz8sVbtX9YDYVr7d6nR993/3mgJN57EUUDlmrX0=; b=NNMxwHRJa6wYet8NBlo1PYWQE0
	o7pYQ7yoiDbR17HizwydOIERFYCQyfn2jgXU2XYc4U1Jo7z0I3D+Z+p8nBMe6GQyBLz8y9QF3PqOu
	yOr6iGbenFnynBCIuFLzzLzs2P67PSgr/MYtaXCjRTyMU2Ny13zE3Z5EWUvEVaYxHUMc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuobg-0007FH-0D;
	Fri, 14 Aug 2026 09:53:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuobO-0007Ez-LZ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:53:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=anB1eWyEB4Bt/Tjt/W8oiMPcNP0REJt5KupcaUxoGA8=; b=cEKUSEBxkrcBnjCQkymjhiBZX1
 qtpAv/Tv1yOuPkMgvNAlg+nYo2Go0D9APUY15vha0qhoGXh8RUNc4tbaX1jGwlOUJkHQb9O/scvHZ
 hzejF+2c6Fr2q+hIKJoRlJqiB/16tswlldTcBI2kHyOh0+yJ9VHEyK8rXyWTvA4/dN+c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=anB1eWyEB4Bt/Tjt/W8oiMPcNP0REJt5KupcaUxoGA8=; b=O
 CFZaTYVGSZM2T5SOzgva14sKyXk0Wk9Nvm4LWfXPRVzytqT2WsbEKVh7XYQKmlFb+3PGy+3U6UQHr
 dwKUBysFR0X3Yy8V998fiO2Ej5HiWohAnemJd0lfZ62/WKP8GOVZChUED/6VM299uhX0WnRvDaqix
 SpfVLefJecKSuThs=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuobH-0000Iu-NQ for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:53:21 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4954dff6536so6896465e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 02:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786701193; x=1787305993; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=anB1eWyEB4Bt/Tjt/W8oiMPcNP0REJt5KupcaUxoGA8=;
 b=JfZ8E7AN7QSqJxCwic7jy+kl3hDVBi5BJ6gyfaR8xcJbd6ac89CtZmJGni1U4u+e7g
 om2ZzQDl/RwJJ+WQdbVZS7BWP9a+sIojL27mzmmMjF3fyqLezzBEwCN84doepr3MmqET
 C7efi1Gvc3R3BVue7zs2wj5QaQU1kS4gN/8JhNI4OuELvPlMfWknD8Xtwu+ZuA/lULDw
 K9c3MU4JXaPx5TnH6JH7+LZryT/62c525TuKdSH3s44NNrcfWJL9ELdqIH5yGw7Ws1NX
 nfxgvdrjVhgm1ggOs/X8IFl8zN/PyXk7BeQCSXrdTj74WK+ZWxEJnt1gASddC8UpIU+C
 TEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786701193; x=1787305993;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=anB1eWyEB4Bt/Tjt/W8oiMPcNP0REJt5KupcaUxoGA8=;
 b=k1jf/B0eT8dAVVTtPXrfRQcCHT74utymF8C6qr3s73JQS99vf6Kayv3SosLuSY7nQc
 PGHUy5DHdo0Qy72D5YFUX2uvMfnLwyLAHFgw2HAkKg+YBo84PolAdU67k2azmz7Wi6Cj
 sytS0TS1oy3WHK8QPzTNwd7ft7IJjH2MRJU3Rhuof3R2vkHaBJ0+c9Blz7GvA8c8vZ2q
 v8qFa59HV/Hi+vg6Pz4+KYZv1doD/KdTFoH+/TsFDWJzN0nwUqV8O4f/aqkZ5kVJxrEo
 OyLCQZ4q/NLtNpGC27oaTHVzBHQVioS+kvVXVVTWYllsx1rXYneU3sWT0CCt2lAFQxFy
 2e3g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrsSzd9b0NKzbZHXW0Egt/0FYthfH/XczxKRKPE8K21w7miTYZY/ZG3eso5GuET4qoX52yef+035bHhoXH+@lists.sourceforge.net
X-Gm-Message-State: AOJu0Ywh1IommT4RRPFdzRVMOrnMkf/rauRsK6X/YXhEWVZ/4m8XL6Sr
 ZXJLE4GrPH/gzJb8m2AcDavp+Td1Ht45LwJVFssqpwKAge/e5NvRlWFA+UD/dk7m9dupbwz91VL
 aiN+AyzTmL/wvbkiOpRQSfwb9SiVxqprvr7870SbQhu7bCFif52zZMqMIRmBemAJgfoGh
X-Gm-Gg: AR+sD12IESKGfH4p724r5e6Ytie0baxi/3yDeYha7eqdj4SmxwNLwKQjDZnx5AbRNNI
 bayZitqQgyGVaaDyR5BERRywPEZQZ2t7U1klHA43iHGr4Jfjl+Xv9lbppVnZIo/fa79n28lrY6w
 rsKh1pWVQQDpI8w+dWZs66WsQBndYWJAypIUbwuNQ6BP6xJucirauUdfj+OpLLRo+HooiVCO1Ai
 59hKRCKEjDQzW6c1jM2MHUkRclwRkGMZEju6XJzm2LIyssvA+t49e9Fc+mPMTsY0VsT/bQa0CBg
 QWxQ161/BaN2rkSbAvZuRr81UYk9MaMSAqh06+i9Y8vQldISeL7HgrRT46kdsHwP7dW+rm2F8C1
 PAuvh6GxmgiYY1fkDw/1lI23mykFV3MsMQSFDlZ1lroI4v+8O4Ln/s5enCyOFzmdB9O2mhHp8DG
 87bzjCt9EacdcN1HEQb+twm6EI+pK/DoTFs030ALapgRkUd/nNX3ISXmxmdVv+82jspsN73cbHm
 bh9w9I7Ys1f+srRkqLnHBpL+2UpwNXkCHWCx+3kCO9q1ejGwdU6qG5nsYSEHxUJOAvqv3+nUnm2
 yBKepJqhLPKzqNpbyPYPJLjFBfmFyuvo74I3+Wy8JGC8R/2N4OE=
X-Received: by 2002:a05:600c:37ca:b0:499:858e:de42 with SMTP id
 5b1f17b1804b1-49987935039mr61661125e9.6.1786701192913; 
 Fri, 14 Aug 2026 02:53:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988adfdd1sm36448995e9.2.2026.08.14.02.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 02:53:12 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 09:53:08 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I701452496bb47c58b9728b08104dd5cb7823a94f
X-Gerrit-Change-Number: 1526
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1526?usp=email>
X-Gerrit-Commit: e468f87961d3cd09d0dac64d97974426339e2931
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 09:53:08 +0000
In-Reply-To: <gerrit.1771008284000.I701452496bb47c58b9728b08104dd5cb7823a94f@gerrit.openvpn.net>
References: <gerrit.1771008284000.I701452496bb47c58b9728b08104dd5cb7823a94f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzcxMDA4Mjg0MDAwLkk3MDE0NTI0OTZiYjQ3YzU4Yjk3MjhiMDgxMDRkZDVjYjc4MjNhOTRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0af0cb7c996d45f8cf77fbb0165b021a6f96fdc8-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuobH-0000Iu-NQ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: options: Change all
 users of positive_atoll to uint64_t
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2554938484496587493=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2554938484496587493==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aR/dLL5/5rQ="; charset=UTF-8

--aR/dLL5/5rQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld=2E

stipa has pos=
ted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1526?usp=3Demail )

Change subject: options: Change all use=
rs of positive_atoll to uint64_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 9: Code-Review-1

(2 comments)

File src/ope=
nvpn/options=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1526/comment/8=
a283739_5f736daf?usp=3Demail :
PS9, Line 869:     o->renegotiate_seconds_mi=
n =3D 0;
> Setting this to 0 is now a noop as it is already set to 0 throug=
h the CLEAR(*o)=2E [=E2=80=A6]
Hm=2E=2E we do have following code:

 if (op=
tions->renegotiate_seconds_min < 0)
    {
        /* Add 10% jitter to rene=
g-sec by default (server side only) */

in do_init_crypto_tls(), does it me=
an that this assignment to zero kills 10% jitter?


File src/openvpn/ssl=2E=
c:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1526/comment/9f6a9cff_7b42821=
1?usp=3Demail :
PS9, Line 110:         if (*reneg_bytes =3D=3D 0) /* Not us=
er-specified */
reneg-bytes 0 means disabling byte-based renegotiation acco=
rding to man page=2E After this change "disabled" and "not set" becomes ind=
istinguishable=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1526?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
701452496bb47c58b9728b08104dd5cb7823a94f
Gerrit-Change-Number: 1526
Gerrit-=
PatchSet: 9
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Rev=
iewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: flichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Comment-Date: Fri, 14 Aug 2026 09:53:08 +0000
Gerrit=
-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>

--aR/dLL5/5rQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld=2E </p>
<p>Patch set 9:<span styl=
e=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px=
;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1526?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1526/comment/8a283739_5f736daf?usp=3Demail">Patch Set #9, Line 869:=
</a> <code style=3D"font-family:monospace,monospace">    o-&gt;renegotiate_=
seconds_min =3D 0;</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">Setting this to 0 is now a noop as=
 it is already set to 0 through the CLEAR(*o)=2E [=E2=80=A6]</blockquote></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Hm=2E=2E we do have following code:</p><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"> if (options-&gt;re=
negotiate_seconds_min &lt; 0)<br>    {<br>        /* Add 10% jitter to rene=
g-sec by default (server side only) */</pre><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">in do_init_crypto_tls(), does =
it mean that this assignment to zero kills 10% jitter?</p></li></ul></li><l=
i style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1526/comment/9f6a9cff_7b428211?usp=3Demail">Patch Set #9=
, Line 110:</a> <code style=3D"font-family:monospace,monospace">        if =
(*reneg_bytes =3D=3D 0) /* Not user-specified */</code></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">reneg-bytes 0 m=
eans disabling byte-based renegotiation according to man page=2E After this=
 change &quot;disabled&quot; and &quot;not set&quot; becomes indistinguisha=
ble=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1526?usp=3Demail">change 1526</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1526?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I701452496bb47c58b9728=
b08104dd5cb7823a94f </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1526 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div =
style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert=
@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: c=
ron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Comment-Date: Fri, 14 Aug 2026 09:53:08 +0000 =
</div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div sty=
le=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:no=
ne"> Comment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>

</body></html>
--aR/dLL5/5rQ=--


--===============2554938484496587493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2554938484496587493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2554938484496587493==--

