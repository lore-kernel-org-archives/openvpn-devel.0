Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0ED606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Y78KMKv8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cN1nKZIu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eqvI0qNP;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bstzZ945
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Y0yH9WWce6S549KpCqFKtFnEId9ijOYfKcSWg2tRw3k=; b=Y78KMKv8Us5Ay66d2MHXMB8GPO
	45xCQZIVr7kB6aUb28IzB9znABdyMr9+ZPQ38DJUwofQ+/f+Gr05QRSqFDZtEva9VoVKLe8HpBEqk
	PzfVDpwSQbodwz3cpNDWzwXWdoP7cuIg1/TTdRcMFmvnNvcOXwcrGOAek0GKxWbvzOHs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOD9P-000000000sP-2LjT;
	Tue, 03 Nov 2026 11:58:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOD9N-000000000sB-1Orb
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:58:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7SsxgvwrnhSuaJDmMmsqwaeN+Jn/1kRm3XbHH3DQt1U=; b=cN1nKZIunH4fA3kW28C8vQ8FMt
 lgD0q1QwyZD8nAELLWsdVSrdlLpi0SSqECpgKb0KcZ7glG04C7LDpPNkLx7K4ow0zom0LQk0cIvHb
 n2i8XlKW/dPAP12OVA0yP3HFKR6B0slFhlxIH0MTdkCfhWIkbM8akP+Kc3z6vnkEf/0c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7SsxgvwrnhSuaJDmMmsqwaeN+Jn/1kRm3XbHH3DQt1U=; b=eqvI0qNPzRkPLo9EbTYog4e2Nk
 tG72LfOWeCbb0VFgiyiwVtAZWgIXBpIIS5ElCjWGjAD0CHVYyiQ/S92hDQGfjCmzwp+j8opfYd5+R
 fFm447gJhLClr+FMY6TPUiuDCSrY4Cmf2A0JI4rwrIwYFYJ9qSJLjxPCt73GfIBaRmhI=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOD9M-000000002mz-1pga for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:58:01 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so3338393f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 03:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793707074; x=1794311874; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7SsxgvwrnhSuaJDmMmsqwaeN+Jn/1kRm3XbHH3DQt1U=;
 b=bstzZ9458D0VLw7zaUF4ifxFPEoDBtar4qKuX0P2nSEK+wLZHeRQ08MXVzkdfLXu/e
 zLcttYcj8Qj6UK36aWgyXvocybbMBhzFi0mqZU3xMy1uvV6zAQpgPKPTfq/N9lSesazG
 QyAYfOLV7nkgCgrWeZx3IFsZSP7DPuQ90m5TbatPxIIRiPvO2LuAJKdpskKNrJNjbcaU
 xJKfaBmIMUueQ4KDu+GKLW478NJi9TAb6FZg2C25j30x4swCw3F68A/4l9rmbGEnsj9h
 zkrZTZE0KQGejjzlT/TtXn8w7Dip7e6FOHFsUODtGh2xtKokasR8wICLhO0hFk4LAnTJ
 n4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793707074; x=1794311874;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7SsxgvwrnhSuaJDmMmsqwaeN+Jn/1kRm3XbHH3DQt1U=;
 b=wU4I5h9cUZnQ36hKxp/60FqbFAfk3oaDZN1eRXZy1TwLNX/vnR2u0qF2yYZVTlJINK
 CcMleK8Lx1MAJGmSED5A+TAE7AIlNa2TTe3UF5qBRc86z9pGTbV7ClIkT1ztDsCBT/sC
 fj4vvXb4nl4aFonsdNiDAUM+x6ByQCwnUdh1J3Td0uY2j8sfFQKlgEyUY3MZbMkEsHeG
 6Q5CpAwk+ncp7KM7T5WS1BrAcJhf70vbHaTAS9zy2mLOhTAuiKHyekFUd3FnlO1+gulc
 zQGuXh7Ar2ep/qcDZsMQvjt0Fs92pESGgiECBo2CCvL+RrkDlfiLsHl4NDS9EYtOdJlq
 p3QA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiKmf+NArIUXl1NCyrHYW12EwfZlztm3fYktGcrtgxRRr+dBIf6+EsZ8AhxczJxLXglZw1xsNdd8p3hOSS@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/tXXEuHNw9kAmXx+DZ4lt/ULOFKNPNHnSqgwpaQVvBOyvZs+Ga
 oldqooERzX+JUlrp8SiQXvWdNfxh8A+hQhOE1bnvAZsiZ3fzQbczWebxSC668P5CirGF+utsqS8
 gIZsiYQRXxSkWA/K47wP1AbLF29+87M8oI7Izyb0XSQhnQ6ow+2cKtKhRMZSyXGGy2qnQVHJUH6
 5BVTyCKA==
X-Gm-Gg: AYBFou0Ci9Fn4GO3qEVo/0rQomSbrwwiFP/7Xrel0CMSAWuHf7F7/j31QNq3qH5iN18
 yFu8+FstZU3uAK1Aki84jPS7LkjGeAY4ZPyWfuoN9pz+9M75oocf06Xmui9ZhYMRIFnM5oTi/wG
 3gvDAdxJJXqepO5dVH/PpvnNAnexFfn0V0DYkXQaMRRSWbEGE3HMici+GUNz1ynuiNtKAU8Oi0Z
 /xhbdUiRtNntz08+LJrBtKrizPpmoJ2DZeSquzuSNqq/HZ+wDHbahZLT3wHI3u3rWu7rQAYuZXk
 pIikuwLRC0Vvrhe3i2bWef4Hdd6YIZ+LscDZ9EzurlHAZvKDR+4ZZY62eda0b50nKYv+QyXcfdU
 ouRwxNBtqAIGDW6tqs+EUrQEc7eeY82Yx8prE8BMD7T9Z6EYtm6LMiM2iiIpQAjqYtxEi76w3D2
 vOOAz7YvBRlWdPmZd5UKE4Y6nm6e5aHSOi0zaJTTAmwf2qDMqtUebk7L7t+Lubk0Y0BGLZAlImw
 La23D38/xi59HKi7jSKJrRCTwd1iXxsKd7qzJvtskNpB5DDgpCRUfJhh/kR1kt+rlpPZwClnA4J
 Hc3iQcodPnRVssxY9SaBJvETZdU/xVpkguI0vD1aBVgd0tRwlZcsXK9QpgussM/3vxtpRJGbmRV
 nN297Jqn/e703sa0RzxlPzh54ejrg6XIUebfd4s+3cM/mfQsyOnv5CwLbajwMEBPADGW76MNkFH
 idibmzwfWNTKRc5w==
X-Received: by 2002:a5d:5847:0:b0:48f:bb68:4e6c with SMTP id
 ffacd0b85a97d-48fbb685156mr1962371f8f.51.1793707073723; 
 Tue, 03 Nov 2026 03:57:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d511sm24138928f8f.8.2026.11.03.03.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:57:53 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 11:57:52 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
X-Gerrit-Change-Number: 2081
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2081?usp=email>
X-Gerrit-Commit: e052d4f93e5bdb4a8596bf54d5b88926d14f1a13
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 11:57:52 +0000
In-Reply-To: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
References: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljYWRiZWU1MGEzYWY1NWYwZjIwNjlmNmQ2ZjFjY2M3NDYxODBmMzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <149e99852e6b83767bf91f5ad2c8aea1a0659d93-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOD9M-000000002mz-1pga
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove support for
 --secret
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2382455730790543656=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2382455730790543656==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M6FpYIntWcE="; charset=UTF-8

--M6FpYIntWcE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail )

Change subj=
ect: Remove support for --secret
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 5: Code-Review+1

(1 comment)

Patchset:

PS=
5: 
The code looks good, not giving a full +2 because I'm not sure if the d=
ocs need more work or not:

- the man page intro still advertises static-ke=
y and cleartext modes;
- --help still mentions "Static Key & TLS-mode";
- -=
-show-ciphers on mbedTLS still says static key mode allows only CBC;
- the =
--auth man text still describes static-key HMAC=2E



-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368=

Gerrit-Change-Number: 2081
Gerrit-PatchSet: 5
Gerrit-Owner: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 03 Nov 20=
26 11:57:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--M6FpYIntWcE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 5:<span style=3D"border-radius: 3px; display: inline-block; margin: 0=
 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span></p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">Vie=
w Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2081?tab=3Dcomments&amp;usp=3Demail">Patch Set #5:</a> </p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The cod=
e looks good, not giving a full +2 because I&#39;m not sure if the docs nee=
d more work or not:</p><ul class=3D"blocks"><li>the man page intro still ad=
vertises static-key and cleartext modes;</li><li>--help still mentions &quo=
t;Static Key &amp; TLS-mode&quot;;</li><li>--show-ciphers on mbedTLS still =
says static key mode allows only CBC;</li><li>the --auth man text still des=
cribes static-key HMAC=2E</li></ul></li></ul></li></ul><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">chang=
e 2081</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2081 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Tue, 03 Nov 2026 11:57:52 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: Yes </div>

</body></html>
--M6FpYIntWcE=--


--===============2382455730790543656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2382455730790543656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2382455730790543656==--

