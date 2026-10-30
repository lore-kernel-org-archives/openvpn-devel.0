Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA72606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iTmKzl3L;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LacVa7zH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SNY9XIei;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZXcf9ecT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GQ/u+NFQusbuWZB95JPsWLmMnCZyY2wfs74NXvAnyH8=; b=iTmKzl3LvBCGzaMsUfGmqZa0fy
	+v8ZwhrTRe68sYvVHoHydvmUiXNDRuV9bZ3d5z/mrsnMwBtYcICJLJqpY+CsBJuTi3O8OWbJfLoxC
	G8Z1WujMmrOVQPtl8AyT58+KUee6gfauFkJTu+PQ96woBGeHA6Go+GgpWxZv6LT9CjHI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMpH8-000000006eJ-3O65;
	Fri, 30 Oct 2026 16:16:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMpH7-000000006eD-45SZ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 16:16:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MzoK1dCGW1RQcdYr1qUqFDLK5+IT9iYNlK9nYlaNhLY=; b=LacVa7zHTZvs7WjrFnC86qsRe5
 fQWeffRFAvqlxGBsif2i44k+G/a2uPx2ukkzjOZ4ZFYBtK9KTtPNw0bqBUBiUgkO49KpCwLFUPdhR
 4zdnjQzo/TISwhhXiIWRMKWZVAOHXrY7a/4JGY/Pt7Yedsd4EIO8z902BBBJ9U8IRGFs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MzoK1dCGW1RQcdYr1qUqFDLK5+IT9iYNlK9nYlaNhLY=; b=SNY9XIei6H9Qt44h61vULKGDp+
 aNKTpb6t28KVpiFt34jOLLFg+zt3GN29/PSgCsVkMjWMOsnhA1PqNeOL3jomQLgHExwcU8eCuqVHr
 +vbdSDmoZASo4y9KVbwuXeSMH63Dw5ZMTx1s9U3QufrfIn4TNUZOXiyaBuIgDAJZcamo=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMpH4-000000006D4-3wvP for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 16:16:17 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so7454155e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 09:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793376968; x=1793981768; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MzoK1dCGW1RQcdYr1qUqFDLK5+IT9iYNlK9nYlaNhLY=;
 b=ZXcf9ecTu5dOXe0DFU/vlUiExJZ8sdZdiGGtiG1xjPkvKdXAs/dz2tllhWbDu4n3Fx
 8DRtvjN8y1WppqZ5T3/rx5bcwZ0xB0lGzKhmqpZ3PJgTnxMzMm5vQZby+1aQsPnP9xVu
 YhlBxjKZ8KFKQAO5THCSeBkttZESh+bxiboHiIzJVWIMiI9oCb3LLvmSIRf1wA+xKzj/
 sicDU97qL8K6reZ5IQZRLmkzGKZoqljkZ1GbA59aqLm0KoLV73sJ/6yKN96NmrmIHHKG
 9xDtqDJF8z7l7I2U0NRLzZu/EuSy7blp9ldaAepb+jY/zJXiA3+0nSuQ6BwzntrYXv4H
 aMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793376968; x=1793981768;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MzoK1dCGW1RQcdYr1qUqFDLK5+IT9iYNlK9nYlaNhLY=;
 b=G2DWwxkxwWgoilJCBVzfjwjSZdvMO9ESCauMz0AqoDBgb6QEKxfT+lyJbnAZx9KU0W
 DDFsSLoaxLOCtufCvkxQZOasG/HFIaacUMUgI7211wch5KRnU0I5KEpseoOrYl341k1N
 4SlfR9Fy3jYlOg3UPtBn8tWVfVxweE7qnnTFJTJR2MkrrdDgM8xtGaI9xXA+bfAauL5s
 eimOyyiDnUvSfh/BEe9UyW5fLEqTOySma8h2UvCyPgYk8GQ83NrhmGMnWwUJ/yq0+zxr
 QjUlYdpX7DZSWqqDUQly7fg6oAtKLmqoUi623mDZJokFxWmXMC/wMI9u7OjDSHMlSPcS
 WVsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzA7XxO0sAFrKgXwECq+Va0uYNxubGbDuyOqOBU7iKAS361Kib2/qZyiJUf03q0JCFgnGbb+xVMVQkKCgSt@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKhu/NFOySOeREKaCdpCNyJ4/+VZpwh/HTc+/0rKPOuCFtyixgE
 tbanV9pkSKSmnPKOvwLYHL+BCOCKIJ9DmhME70BMYb1C/3rGN31drALEE7Fj8dRDTavg4obS7un
 fBtNRMp7A+8b8CnXKL+mtI841BqvyoT6oO1DxJT2FVQQnM7IRE3Df2g86K/PEmTH5oR5HyY91uK
 UAHcia+w==
X-Gm-Gg: AYBFou0tCO4Te2qmE9TJkEXC7EHulzS0B8IJ3kMqg1H/cYdMp5oocf+BwTWML88dbqN
 TyA/bJKjSNVKmb83VUHNlHetQ3EvWGiu7kl4Bw1/00SofAyxfbXlt09HoSmUDZC6zLYSVw+Td66
 XYsmsyzsnhWT9C1WxrlpnVRn0cEFD9mJAgYkuMiVxv7Nvh1qAa+sjKfteIMnnsgmLGQQWtCrInB
 W2yeb8oQC6zg7jLS4jRMJl0XAwLyUNm3SU27USZka0Wim+wO2vRmVklqxcqi+sJw9FuWH/6bK8S
 fKI2s7b2YE+COTEs7PVZ7ASUQGSj9mO1wQi6sxDfGLouKZ8qhu9drPaoRtYNtnQKfDdkP3sCd70
 n3ZN2xjup4qJj92mu79AUJsOmYU5uOOwxN6og/5Wc/mopA8RJI7DOmmhKIXjPzUu3xRV9ESq9C7
 kk+HmgoyWR/JeajKmkBpSb+ntsJuHgpya5+amK3qaMYruLlk2WMqSsyJ90znhYN00GFGoMEIKYb
 r+2lAn8Vg2nFKZx9ANDpI45ZC211tkMYyCSruthOp30JTBe8re1ljAGkqed560B5eSrnxYJ4MeE
 5+k4WKVe43/4MlR4mU9ZsmR38jrvSb934nvueW9vqSXBAMBbWt2hi8kaxj9orGr1QXUH/ztBBae
 3uK2dcQiJzTX/R/dIJFGfWGR6QXPIyLRFgXWJgovPlKTbCEWir45L/EVtnwUwHy2W1OSNNlwvqc
 5pVUcJ0wdaTJTcE5k=
X-Received: by 2002:a05:600c:4e14:b0:4a5:a5ca:de1d with SMTP id
 5b1f17b1804b1-4ac187a80bfmr63666295e9.30.1793376968170; 
 Fri, 30 Oct 2026 09:16:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6e63e0esm91867255e9.12.2026.10.30.09.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:16:07 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 16:16:05 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 23
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 0d8719830b6fb0a55223b6d99b9b458ddfdb63cd
X-Gerrit-Comment-Date: Fri, 30 Oct 2026 16:16:05 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7e7f4cd5511bde490e8b868e2b726469572648ba-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xMpH4-000000006D4-3wvP
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 chugly <charlie.vigue@openvpn.com>
Content-Type: multipart/mixed; boundary="===============3826187742320552474=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3826187742320552474==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8SieNaoXR4Q="; charset=UTF-8

--8SieNaoXR4Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru, chugly=2E

Arne Schwabe has posted comments on this change by Arne Schw=
abe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Cha=
nge subject: Implement sending/receiving app custom control protocol messag=
es
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 23:

(1 comment)

File src/openvpn/manage=2Ec:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858/comment/08a9ab70_5125fc8b?usp=3Demail :
PS23, Line =
4468:     while ((flag =3D strsep(&encoding, ":")))
> The new else-branch n=
ow rejects `A`=2E We should probably accept only one of `A` or `6`=2E
Done
=



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a6a6ef41e1589=
6b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-PatchSet: 23
G=
errit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: chugly <charlie=2Evigue@openvp=
n=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Attention:=
 R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 30 Oct 2026 16:1=
6:05 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-T=
o: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--8SieNaoXR4Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru, chugly=2E </=
p>
<p>Arne Schwabe has posted comments on this change by Arne Schwabe=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/manage=2Ec:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/08a9ab70_5125fc8b?usp=3Demail">P=
atch Set #23, Line 4468:</a> <code style=3D"font-family:monospace,monospace=
">    while ((flag =3D strsep(&amp;encoding, &quot;:&quot;)))</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">The new else-branch now rejects `A`=2E We should probably accept o=
nly one of `A` or `6`=2E</blockquote></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=
=3Demail">change 1858</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1858?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 23 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: chu=
gly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Commen=
t-Date: Fri, 30 Oct 2026 16:16:05 +0000 </div>
<div style=3D"display:none">=
 Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--8SieNaoXR4Q=--


--===============3826187742320552474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3826187742320552474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3826187742320552474==--

