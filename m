Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00ECC53219
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 22:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0HU8VuX54Mus9w3yMMwdpOWyu5L8rtv/ZieMRcsmgX4=; b=dxb1BA+jukS89wH7rQkhX5EgBY
	y+67e8X7iSuWMqyD/8Lt+//1+ubRva5h6kFQuxhnkwBJYMdP3cNJxmw09+/xacAWYOQD1r9k2muOj
	LfEbz8nXSuiMZ8U64SF9zam4Mptn6xmQ0wGz36TjMyjtOoKxX3pb8sIR8OJpP2/LNMHc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woqGY-0003WE-Dk;
	Tue, 28 Jul 2026 22:27:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woqGX-0003Uk-II
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 22:27:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=k+WZfdRVlGGvuNYT6LjtGlkNbeyrkkM7/Ltsj6Pbmzs=; b=OjxBGyJIEdhTQEJI4jZj/u5hF8
 j1Wv3HcGj0gg4lJz3C9lX7XkvxOHi2mve4TKMArafuMgMginGZWpABT90SO0ww3ebTTXR9e4fp3Mx
 UEMch5t6GnhHBCZMB+VssXO1DlQ7tEB16FEeJfoPWcpCX3O1EoPBoVN9R0rGJronNMfA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k+WZfdRVlGGvuNYT6LjtGlkNbeyrkkM7/Ltsj6Pbmzs=; b=e
 DfxO+vDVXWUDD0vh417gxyOyAuFQS060PZFHevQAieLBqZfjT9/hEGLdOstBMY0qjahDawXrzu4Xp
 0ncSW72AYuuPHGiSgkmncKX8kHZBK1PvcOauQA8uCn+ftNIbBH60BbF5q5udRlRznTydrdyeP9AF0
 0WXnqQFKCuUo3OMg=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woqGJ-0007GC-Hm for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 22:27:00 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493f6de72faso2299465e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 15:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785277613; x=1785882413; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k+WZfdRVlGGvuNYT6LjtGlkNbeyrkkM7/Ltsj6Pbmzs=;
 b=W5luQdSgk3rBTpwABUNtxX7lhuOW4Qo6D3Tcp6JxS7Lce0zf7mU8Q2/0KE15xdLFY7
 nJKTG2/oyjTP7urAZ71wsikothx5L9x/MqxxTZ2PCn6Lbqs9j2kLOpvIeBtfqbpOujmp
 Jiz92PI7IbT1uSZeXoSDgYvlPTDsrGEkOL0ArSVPEfaDAKspwvXIMtZ6KflhckqlGl4g
 bPryKVyBjFb47Hk6eIyM5iUBLNuJe22hUcQYZvS8/G1/Q+0orPe4fig/1ApFRaY3uS/8
 fZ2zij1gA1m8RcnMN42fOLsX8Zgqfs3fzGhaxylqx6GejYdJdbm3enIbATKcjhcU8wn0
 ZjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785277613; x=1785882413;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=k+WZfdRVlGGvuNYT6LjtGlkNbeyrkkM7/Ltsj6Pbmzs=;
 b=MBW+PxEkSJcy1rgmaLmaVwse6GS9JwS98FlebWt3UEG1+WzHMQr4gmenB91cyK2XM0
 4Dx4W3Kk4sCirOrfDWqCiJjObV2ahOGML373k7mxtVmEyVcpId2lEIV7+f6VcEgQ1aqi
 p5gGS3Y5xWAQ+lvvO9O8pQkvQgnqL+qtT2TrEgN64VWU4I0CCXXmuJfGjknEpQ12vVGc
 eSfqZBB4u6mwOfnPE3Lh50AmzL9K4boHBZKb8sfSTPIC8HcflVpp1SYF8Vg0eiVgKMr+
 czR3Y7h+1R8VWRjBFeTslMPg0PkGhbuBlcVazkUZtlr2IIGUmfHW16SUmKUhbItBcar0
 lLjw==
X-Gm-Message-State: AOJu0Yzt55YRaFEaZYFJQ/YDLLXPHshqptfvtO6CSuCU3vV5O2ozMG76
 r7qU94TJM1mBA7YM3xfHdiT4c40Dtu1Bbx/uMvQJsgYI0oYKaAB2AfJiWWK9jV/Fly8VzbHim+1
 f4hu6QnvQdR7AUJAFI2xAuRUhSuhCsH7vbISjiSqODISXwN3GlBRPlVuMffNAiifMVKMy7b+H8l
 cgF5aiQQ==
X-Gm-Gg: AR+sD13lJzVOISGCfvzeTfbsmEyiRn3GRC+DND7Um4f9XeliTxUodZmIvIOKjB7YEPm
 cVKZbT+kVqZ4BiRt8GybSH5uBYcYZjU9CXRAAfRMrpqUAOIf3h/oCSCkU9LbfoPDq+yWhETB4Vg
 T9ghl2apQlvNpRG4iak/qdCZWZGjiblJgM/QILS5qnpZNH6Ka0usPg5SeO6tmNt/sHAFmOWTuOJ
 m5eLyZByM2fk9SjHOIxVDx1VHFVk9Hb9dOZHtQlyQ3HHlbTZrwxcB3uHSjPMd7zNlZw8LUApC9/
 IaKUvY5iuJLkiNO2IBJWlqBlB+tNobCgI1nLbENb5BYH6STMR7nVKq9QaakGFc0yQC10JtFmi1W
 ZLz2Nvary3OMJ3y07OQDv1hBtLnlLEJcQVPa9O4i/NdphxYk11LvYKAM1MeNwXhik0m7eyO3Xfy
 dCrLeaBp2bhB4G6P1yN5vDCQaMxZ9WLnf3CChI2N6XYmK+IDkP8hkkKOC7TWaavUzD4KfXb47W1
 gm5rGZLsG1fo8h2xhe9JpeJpZyLKYN3UeLQIHt29nO9sKS0O1LXKh0/e3YXs8ajQ3/0jod7yw+A
 QnNfbBG1Yg2L7IUYawiX4gLZr1ci9P/SMkIxj4D+ZbJCrsAseIo=
X-Received: by 2002:a05:600c:8b42:b0:495:3a52:71b1 with SMTP id
 5b1f17b1804b1-496c6431e51mr45386345e9.5.1785277612976; 
 Tue, 28 Jul 2026 15:26:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496e905fa40sm13355045e9.2.2026.07.28.15.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 15:26:52 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 22:26:51 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e
X-Gerrit-Change-Number: 1829
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1829?usp=email>
X-Gerrit-Commit: c4c3172a707875fbb49f214adb2c12526d545488
X-Gerrit-Comment-Date: Tue, 28 Jul 2026 22:26:51 +0000
In-Reply-To: <gerrit.1785264441000.I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e@gerrit.openvpn.net>
References: <gerrit.1785264441000.I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjY0NDQxMDAwLkk1Yjg2MmVhYmUwMzJlYjRkMjIyOWZmNWIyZjRmNmFmNzQwNmY2ZjRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0816132e0ca9e1ac1ddf631c634a0277c89347cd-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woqGJ-0007GC-Hm
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Correctly calculate
 packet id size when epoch packet format is in use
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
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3832863453316550712=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3832863453316550712==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cUFTGmT2zmY="; charset=UTF-8

--cUFTGmT2zmY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

ordex has posted commen=
ts on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1829?usp=3Demail )

Change subject: Correctly calculate packet id size w=
hen epoch packet format is in use
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2

(1 comment)

Patchset:
=

PS2: 
commit message wording can be improved a little, but it now contains=
 all the needed bits=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1829?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e
Gerrit-Change-Number: 1829
G=
errit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 28 Jul 2026 22:26:51 +0000
Ger=
rit-HasComments: Yes
Gerrit-Has-Labels: Yes

--cUFTGmT2zmY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 2:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1829?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1829?tab=3Dcomments&amp=
;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">commit message wording can be improved=
 a little, but it now contains all the needed bits=2E</p></li></ul></li></u=
l><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
29?usp=3Demail">change 1829</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1829?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1829 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-=
Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Tue, 28 Jul 2026 22:26:51 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--cUFTGmT2zmY=--


--===============3832863453316550712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3832863453316550712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3832863453316550712==--

