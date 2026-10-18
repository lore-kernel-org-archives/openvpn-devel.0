Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED50CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 11:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VHoVVveJnY0gePdd4vwvr2NjckPHG5Kve2kst+mQWH8=; b=kTesW9cJrzggc6jCQo1zO2GmIR
	J3f/oxxO2ZWnDqwaV3Wzi9pph8gzV7wLkuJ7IyDR1V6i9bIRTu784POKNVjCuc31SV569EE6XcQ6o
	Sa7mSQxDMCNwALXjIIMIbQq22w+EHownGIhlOVaco7bWgY6u6IDWtW3+SZ8uFBCK5oa0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIP5S-0006mL-Lu;
	Sun, 18 Oct 2026 11:29:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIP5R-0006mF-KV
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 11:29:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jIJjJwXu1jb/eYrYfBohCoeGhW/eW7CM7kqKeens7w0=; b=HSKDHS6j0EpgHt5MfnI9aUa0Ij
 P+nWQlfZfG+x53u9IhG6tB3Anvuh9w7Wv4XB/muy3vRiPj4gd3XTBx0/VV+9NR3FtSxq+cECiEpOc
 ls1SMoAqr2KQWxwbiKi77AzQXXsnlbVnOtcZdxr0smWyl8ScdMEialvxOdIWrbz8/sgM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jIJjJwXu1jb/eYrYfBohCoeGhW/eW7CM7kqKeens7w0=; b=D
 5BsNTB1r3ifFja/75QPcpmJoScHUWQ7irwlF+YZ1eUqrNiN3L6qRt5jTrCiRTgo4QGqPehbVCyFAB
 bQ+tA6IywhToPSPh4Xcsiq/ViEolYRF+XLXjIgVjIwld7I1vJ1NGeqqdQcSaYOIOUNJJ1dRSj8Opa
 PvgdZJj7LaJJff4Y=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIP5R-0004dk-CD for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 11:29:58 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so15639255e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 04:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792322991; x=1792927791; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jIJjJwXu1jb/eYrYfBohCoeGhW/eW7CM7kqKeens7w0=;
 b=ac7BMa/w3t2qNdNH0Mf8nMic8kzOCD54BhPsryBpCDXEasVtJDU+JZW5rqiGTTtSPP
 YJMxJzCKaj9lmlFQzfN/9RDDEZFBEJlPuBg67A6Wf86A31/Ltjnn74Udb1HOjnLb/t0F
 fKnQfdv6DskQOpJgRDkLynbDgcg+e/DJ2E9UfoCxigqfLRiyT5c1gniY1ZcZuTvHYkcb
 A5MY7gJdZjJ2O01+3S4mMlVhZ150dsPXiZMK52398vHOX2FRXe1t6xZ0zHFY3uEAUrlQ
 eVm/xp8zOOx2UHx+JYqKkoz0xteYCfZp+gzjGZOStL9TOfZmeWZYq8eNTFmRWZuPwNx0
 83qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792322991; x=1792927791;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jIJjJwXu1jb/eYrYfBohCoeGhW/eW7CM7kqKeens7w0=;
 b=UeLbnhjqmSS+KlAhslpuGIH0P3Xxe+v/zs9sfcb9nyUvEmZ0bj7qsdTW5VdvhRf+cU
 b7pkOrb5XuneoneFxl9eKKsZedzLWpBrUGXYS/CUm7iN7w0jBI6lFpB489yd3zh6kK6U
 l2pkyp1RpSDY1/IXidzv74DruK6zmYSS3+XvUfy3hW+yIzWmFbQciNom6F/zhGY+afH6
 QUH6fM1kkdV5bOMBkPtLaq06rfrMckD+3IlR6quxxTg5rZD5WCcIVwOdR1/597C/HFHt
 +9KIzyTF+O1DsWRtlvKBSmcJGjxy4W1W7Nv2aTxxVnnAhn9W3OrWS7nSRwyJTo13VU2a
 gv1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzyr/H1x5d8pgtgGJxMpmeBfqmEkDzsgMCCjVCvLAdCBMCcaBmHjTsBTGKCEWch97WrDowOCbKcKxGC7F0@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLP+LaYckn3+le7sUvqGTLU3COblBdJrDKDuMz/k06KJFFlafAv
 98kdsi2cARlZ3MmKVkbCqObiTmEXBWLPpIpBRmzFu0O1JHZ7Ckt1aYbdeYo4UGfK/E4N0NepvIv
 85yJ/bjqi9HzcQGD5WkWCbffDqib3Cubrhpnb0E7F7Ev8eQnrDWC3E2ng+P5SQvoii9kY
X-Gm-Gg: AYBFou2sCkbhe3vX4fvIBF/te5swRx4XHfKWbbX6BsF/q1A/U1Ovi+nNyotB6m9cbW9
 8wxMamjKG1kzjgD3FAaWk3XzPMFb1CfZ2fGFMkwunG/P34B+qe2DTzqoIRee2JFJO8u3xYbhqhy
 MbZo6YmNVfPSeJBsqHiG2pAOLu+VdzMSKIt8hT252jgN3AA+lAhEDjTQfgqTPxZCldnZIQb+MOU
 dzW4x7bL1tqP43SsHc8cINVhu3VeUGyIuIHtbiLCqoagr7OAD96ixkwQd6N4WJhj4B7++qmQG/j
 fxJEQL2QKAwzWlzgOdWaCi/c04yEzGGAHPPDu9SYYcPk4zVsaboQJt02GygdOAb8bGcn5BLdHs+
 IxqPL3sKBfsLljrW5sFHgZRuTVZ4bCPKmWaSlr7ntlqf8LnIeybdvGjSJFef2eNWzAg7zqnfyhE
 4lEAMOnbxDJFnFK11zKjXS2Up2iijHS8XE6N70WDUJtikZxi6sAQ6rRQ6myNZ2kPH44gDAHCW4I
 /bCGV3b0+VmruDZRnrlWOTDyVo1n5fRpl4PTiZIx6GyyWpUGa2/CGTPAZE50CX3mUEPPhUyAaND
 bfrOWDOIhZ7WfhxbF4kVP4/QgZBmEf7imKuot/AByP5hdudmq3UIGsKnOE4w
X-Received: by 2002:a05:600c:1c0e:b0:4a0:b6:4619 with SMTP id
 5b1f17b1804b1-4a1d7462e34mr110926395e9.0.1792322990718; 
 Sun, 18 Oct 2026 04:29:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8af2fcesm213205095e9.8.2026.10.18.04.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 04:29:49 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 11:29:48 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia57c539ede73ca4d0fe08b7b03f8bf8652b89ca4
X-Gerrit-Change-Number: 2003
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2003?usp=email>
X-Gerrit-Commit: 38bdb3b3a99bb3a0322a7812c9422543a4200759
In-Reply-To: <gerrit.1792255622000.Ia57c539ede73ca4d0fe08b7b03f8bf8652b89ca4@gerrit.openvpn.net>
References: <gerrit.1792255622000.Ia57c539ede73ca4d0fe08b7b03f8bf8652b89ca4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLklhNTdjNTM5ZWRlNzNjYTRkMGZlMDhiN2IwM2Y4YmY4NjUyYjg5Y2E0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fa9adc1670bdbab88ce9741068f74c7f771eb7ed-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIP5R-0004dk-CD
Subject: [Openvpn-devel] [M] Change in openvpn[master]:
 crypto_mbedtls_legacy: Sync code with crypto_mbedtls to remove warnings
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8395961249863023113=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8395961249863023113==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LRnmO293eTk="; charset=UTF-8

--LRnmO293eTk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Frank Lichtenheld has abandoned this change=2E ( https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2003?usp=3Demail )

Change subject: crypto_mbedtls_legac=
y: Sync code with crypto_mbedtls to remove warnings
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Abandoned

MaxF plans to remove m=
bedTLS 3=2Ex support soonish
-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2003?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: abandon
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: Ia57c539ede73ca4d0fe08b7b03f8bf8652b89ca4
Gerrit-Change-Number: 20=
03
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>

--LRnmO293eTk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Frank Lichtenheld=
 <strong>abandoned</strong> this change=2E</p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2003?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap">Abandoned

MaxF plans to remove mbedTLS 3=2Ex su=
pport soonish</div><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2003?usp=3Demail">change 2003</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2003?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-M=
essageType: abandon </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: Ia57c539ede73ca4d0fe08b7b03f8bf86=
52b89ca4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2003 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--LRnmO293eTk=--


--===============8395961249863023113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8395961249863023113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8395961249863023113==--

