Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF976C61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r1N3y7Umv2UFlFntQDWyjWl6pq+AQ1AhV7sy79sgukY=; b=cxXwtEddDDKl7xLHs1uPtkffkB
	GYnj7NNr0waNYBVAsgydqK9JaiPfEnjWfDhEITRlWqrNWo1Ss1BqbaivhDeGKZPxkLvdCqKLkxsOE
	yokwVMhnmI6ghG4h8XUFQVyoXpuuQIvCUfLjolbEhd0k9FD66mMPvOcQqeWOCqdJzFCM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzFlE-0003Gv-13;
	Wed, 26 Aug 2026 15:41:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzFl8-0003Gj-7G
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:41:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8pjjhpJtVgiG5ZR4eOYKgNhXFo/GHPgOKMrwZc2fxgc=; b=Eax0fvhhLd1Zqd23l2WrdSG5ER
 ZCJrEbA1mB2cp1iSmcFFExdhtVcyOioWp47MHE6PQk5luWNfW0FFK7suHOZM6AlL1Sc2SU3WGR2aS
 2TPFKCdy7bSKak7hN/9ZYsiXREL+6vfKG9DNFFa8ZF7d5uahe/RJ6yHZab6mMHMJy8FI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8pjjhpJtVgiG5ZR4eOYKgNhXFo/GHPgOKMrwZc2fxgc=; b=j
 9T4X0b1wQ4n0bZY+1tXWdZ7AB2kqbLI0NLxrFr0g1lYftS9jaJFCv2Wbcw21mj0dTCacQyOYU29ay
 BgB1XEBZkVjeqQrp0HOmAioDXMrEGhUFwecuCcq3IuLvHs5Cb6DUfEsl3y2FN7MvrlEx8Y8rI9nAU
 c+alFWAF8CFSpBbg=;
Received: from mail-lf1-f51.google.com ([209.85.167.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzFl7-00005r-Gn for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:41:50 +0000
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5b457a0b4e5so1013651e87.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 08:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787758903; x=1788363703; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8pjjhpJtVgiG5ZR4eOYKgNhXFo/GHPgOKMrwZc2fxgc=;
 b=WVlpbsMYqy7/KZAuMw84XZQLk6ZbiegnkEx7hr9f4OHY3nvz/EyPx/sSqe3lZGfano
 FaFQlRWesh0elmJmc8M3iBOAWsPoO7kfaZ8HxlHDbzWtsJDAlF2nawyNCN+s+0RHP59e
 2d80ZffHpJnQyTjapw4xcfYeuqkKPFWWCyY3fJSXRikiMrk9qmDiFnvAhUi9vkKjWm/A
 xx+s+oNJqCc9sBsCQdZxkZmGOVVGmd5f/j3UcGWJbFTZIBjxd0+Mtxq5l/AWFFmY8s+y
 MJ0oEG4TKx2fSIqSEnlxBLXRNvq2vCxSE2lnZDCox4DzeTq+oHTX/RZeO4iGjglT7FiH
 Ig1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787758903; x=1788363703;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8pjjhpJtVgiG5ZR4eOYKgNhXFo/GHPgOKMrwZc2fxgc=;
 b=JwDY0sHPus3czOVFXkKAGcg2ZkYvR+5Q0zJFYiY+DuQnurjVO8UtqpBeedqzAJL4Uj
 Ao10nR7lRxNJ0kFKnFZ8EkNJ5aVXS8sBqw2BZb7TV5s6noqfEn3Yp8HTIqR8VqKDsdHy
 fe3qe5IYxEDEbf2pGGXn2PnQ2RP1OBkQ6GPVtbHLOREtJHXL77CWjUUbZOmFKYaeag5i
 Z40lLNLY92cyn6ni/eg1Aa3jr11+imyQ3skrhGAHIHpLdKaRj3HSOppIn0tspDico9w8
 h4Lz65wQ3s1P0OjeX7G+psLgGl/ICXJl5aquv+oT5Ii0V14jV969jcsTiN85ULMLGhEe
 FPTA==
X-Gm-Message-State: AFuF++kjCJIom+9HGWrQwkCZsH7TdtsnYqlKuwJvQNk8mYae4Db13muI
 /XHYvWJ5mgvdix7CkYIie26D7NkASmvesTCF4chEHGYNZYRLANcaOHc/2g2miNR1+AwAJzIiGun
 I7ZMIyffg/q/2C1NkOIOQ5PSgS+Q/QtjQ94p9gy1lxxoAgTTF9/98cmcRtn37FE8DXeyqh2HPhO
 I4IJLPhA==
X-Gm-Gg: AR+sD12oSohsUwhZgmxbUqvoeUXDYM58Qo6MikTtVTfjALMCm3FfB7VQseR5oEIhuwn
 L4DmKykHyekzfNofTKEEnSTZX3meZlgZhoAP/6ye50QqEESrnNC+VkqmvpPx/bHT63plAWz6ui9
 CQMMlLcXrjFfPvHc2qYsHxWz/k81pnJ0TTAirTXHYPWHskGsAFpqY3nBcppoKmgWr5Jg3k5vtX4
 ctsXkadNRCM82EsGtf6SDieqNKselj5MjFP+NAftCyQuODoAp2DE+y2l4sm6oLRLR7L2fdeB2KI
 KTmMfzHl5Cx+Ge5EmumA4uxWLHfqYJF4uJrPemEW7KuQ5ipyrteZMAIVnX0rtQWdQSZCDtR8XWi
 Y8EGwGEV9eaATOtCwIJ+hdHmt3JR+u15OQQn7CGBM4KV4gZF6O4bh+RfoQJ9bDwzsFI/WjyOGSk
 kr28iNILI+qd5wUh6lONRCTlBJxshCtPRNxz5V/IgJz0lnHeLQAmlC8WhnnjRDVOlQNd7mvc1lp
 dZQMLwCy/Lxa8qBYBtZeL820GkN4TBxrzNHu2bC2DQjsDkAdUto9A7AA6AqUqR4KrFA/o4qydb0
 S9LB9j7siuHt5m9qgdrhQW4ELL2+ZGqJQI1QDD9bxgg7zfQCtC2+PPiWy91sng==
X-Received: by 2002:a17:906:fe4c:b0:c20:5213:56f1 with SMTP id
 a640c23a62f3a-c250c315049mr944017166b.13.1787749084626; 
 Wed, 26 Aug 2026 05:58:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9ef996sm576931566b.62.2026.08.26.05.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 05:58:04 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 12:58:01 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557
X-Gerrit-Change-Number: 1856
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1856?usp=email>
X-Gerrit-Commit: 1e7ef53850e82f41b9691003c30f1f125e2a60fb
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 12:58:01 +0000
In-Reply-To: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
References: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0MmQ4Nzg1OTU5YzI0YmY2ODgxOTA5NjVlNThiOWI5ODI1MWI4NTU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c28c5199a821915e158b6bd9b798127bbcb85cf3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzFl7-00005r-Gn
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Introduce
 get_key_by_management_key_id helper function
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4776002068217671854=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4776002068217671854==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ExmgaZ5sf/8="; charset=UTF-8

--ExmgaZ5sf/8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1856?usp=3Demail )

Change subject: Introduce get_key_by_manageme=
nt_key_id helper function
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 6: Code-Review-1

(2 comments)

File src/openvpn/s=
sl_common=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856/comment/e8a6=
9349_62952bb7?usp=3Demail :
PS6, Line 764:  * Gets the \c key_state  object=
 that belong to the management key id or
"belongs"


http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1856/comment/fef06de2_4e158fa9?usp=3Demail :
PS6, Line =
775:             return ks;
The old code did not abort on first match but a=
lways checked all three key states=2E Is there some state where this might =
make a difference?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1856?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I42d8785959c24bf688190965e58b9b98251b8557
Gerrit-Change-Number: 1856
Gerrit=
-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Re=
viewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 26 Aug 2026 12:58:01 +0000
G=
errit-HasComments: Yes
Gerrit-Has-Labels: Yes

--ExmgaZ5sf/8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 6:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1856?usp=3Demail">View Change</a></p><p>2 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/ssl_common=2Eh:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1856/comment/e8a69349_62952bb7?usp=3Demail">Patch Set #6, Line 764:</a> =
<code style=3D"font-family:monospace,monospace"> * Gets the \c key_state  o=
bject that belong to the management key id or</code></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;belongs&quot=
;</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856/com=
ment/fef06de2_4e158fa9?usp=3Demail">Patch Set #6, Line 775:</a> <code style=
=3D"font-family:monospace,monospace">            return ks;</code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The =
old code did not abort on first match but always checked all three key stat=
es=2E Is there some state where this might make a difference?</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1856?usp=3Demail">change 1856</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1856?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1856 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none">=
 Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Wed, 26 Aug 2026 12:58:01 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--ExmgaZ5sf/8=--


--===============4776002068217671854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4776002068217671854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4776002068217671854==--

