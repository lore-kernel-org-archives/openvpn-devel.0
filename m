Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEC8C9830E
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oW9CCXJOk70Kp/mIEA2jCraf9/WO+FfF7VsSzsiCGlA=; b=V6Nwb9sItPKcv0HrXxasunMXr8
	EIpYTS/U7IB1kBAWyExIQUYcjbefHL6/okGjSG9uLKlzgnLfL5cdd/kaa0ZhrwuvZ0lZjYaP2GP53
	A1uRoP97L99e3+iKP7B5I+S5+N+TDDxpQ+y8hUpZhtRRZaYEmsZbgNi6W81jQpx+CQTc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA8Yd-0002bI-QU;
	Fri, 25 Sep 2026 16:13:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA8Yc-0002b7-Ph
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 16:13:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KZW8TTl5jN7vGwTGlf29glUKzdQxMlKVcXAUu3vlbek=; b=Lz5AK1/Tj19JO43NppGZCc2SwD
 ptouHEHhhh9UeB3Tys51uSm8Sp/uTKwiE+77K3HlDdtTjKUUXOGVMQ6chpZHzvs2XnyfJ0O3a0SvR
 F0OK3tfwzIi3IRzH3WohmP5Ovv9Y/paKcqhLaEphaxrea/rWEgh1DvBDvM7wcj/xEgAU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KZW8TTl5jN7vGwTGlf29glUKzdQxMlKVcXAUu3vlbek=; b=P
 OYOSClM6qGogIQcw7rJxIO9jEJGPw2+vgtU4tbp+WNUm7spExwD0deuNQbKwnI+3szNwFHafbozcr
 mIJjuVPh1q5KMZgRE0P/46pe8e2gqM3mgLTqoSi5PmF5CdwKBEsiAbvFPTjRZKwTxVVFu0vVf/Zx8
 8pMU37v4bD5Vkei4=;
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA8Yc-0001GQ-6I for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 16:13:55 +0000
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-4888129c46eso442194f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 09:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790352828; x=1790957628; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KZW8TTl5jN7vGwTGlf29glUKzdQxMlKVcXAUu3vlbek=;
 b=SYNdpZGQ3v0FG7i9kpoHZAe35jTI/pABBbJgQ3LwsxKvXQfSRKvONEOHB28eXp0iK3
 HJF/JlfAbvSDXHtjiajdjAx+oRYoZudYos9YJiTgoaJ8GRZa9TtYyBcx6z1Q/59xqwHC
 XXnEmBkWUc0W4qZWNdCKoTipxp6CwJ25o71XEF7+/5jzhgC3yVdcj5il8NvApTAUtnfw
 2pDAxnLFEgXYGjW1ZdyR1sH2iCp8h6+5oFPGPGORRPcbfGbzZyVd6mz8RdZXBkgymrml
 LetCjbywIGG3Xn5TZndL97OSHfklwSKeNxharWUYIDSGKx+38akjMqczqWXFmaHXjmWt
 W4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790352828; x=1790957628;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KZW8TTl5jN7vGwTGlf29glUKzdQxMlKVcXAUu3vlbek=;
 b=eVZ/BC6bMPu+Dx1ezYb97quR+yT3egMi7nEW61+ISLvhPnXwaSwgDu5dAIdfv1cCbZ
 yGa8WpZLoLxTjH1CTFzGhPW3DepVtDSDVKDzYYzCHmy0Okkym8t/Q09LeOGfZE1n8+u2
 mAiIhbNaVFTaB9MASRnvDd2dVCFWZoOhgeRgvlaAN+2JbQ7EPR23u/D8Z9AzEmj/g8x5
 Lx6i1iZ8mRSq7ig+pWM5NiDPTDCvnHDb05PpXxT0A8jk9rG9zZnXtFYxncl89nCCiNja
 c+Y5OcPKOy4aZtylzckLukcJrSBHdFtLHON4Ev1UpU4JbKMx8fhADCbR0ud6d2w04ERB
 AUlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwy8VkD+yOYjDjjc1OI7UcYuS0yxNViNt2D6XO2HKSKP5nPjRXcle+BfUYbMCWclS4/++ou+EnUdUvXG5Xb@lists.sourceforge.net
X-Gm-Message-State: AFuF++mq/pMPpWZkte8yYg+hnKtPZg5NMxRA1cR6DXc3z906LBFyZEGl
 jQjVdPye/5fq1sqO98Ez03qIy0YztKF6mtbqnFaN2ptJn0ZHY4JSRFzP4BE4J9zd/I5VW48zQWX
 f7xxCgxsu5X7l5lJst/XVyJX7mBjhKTw7r5l9PVIDT7Qp8FdGZaa2m3DoCzOsH0J9P3VoE5i6QE
 IZgoFU4A==
X-Gm-Gg: AYBFou2hasGx7AEP2I5DGpGUVmgefOYJP+R4f9SKDGCQ0MUQ75YmrnOqzQrnuugqRev
 EpOjzA6ayJkRDsQtoIeJeg/vq6rmR5yy45ioUqz0WwWhcji1GNWY7Eq/52G0vzd7QbbcAcCBpc0
 THHV74GpTBPbc6W1iDLX1ejFQiiE31xzyAI9fHWd+n/dGCYZOwVNCzwmFiPTg3IsLyltVzZ+UPN
 yJKyRXMtlHa8QrOffGe6MU1ZIubkFw7XNrZKTpSOKJKlRVve9cax0n0X6Z4toZFwKNr8C2pNJsp
 +84z0FZhzDu1c9vKLl4NZ9BEyNzwE+oaHftKAlZYoRnbbjRIbabX6bztBBDYTOaVrcabQKRdEXE
 CF3q0lwoyIafncTOi5/oW3RCyRe6O/tTul5+/KWO5UX/fX0Z2jyx6oLLvn0D2587bocKdf89d19
 AtjFjsKjvvvZXkquy71uNT0oB218pKC6FzouU7LslHpmCcOJFfwTluQRKZZBSABMfnkq4GP5ASt
 R3EnghlXX3vrLvumhoOd31rOp0+MQxQS6O5WZcGG5r+InJ7DTCatZ/cCnBKUIJf64ekD3g4dFah
 ufRToFvfG1jT4AnVDO4HLUBAJfMZZbhZ38ahOweRAq/yNNqRn2sc8TIGDhpG
X-Received: by 2002:adf:e186:0:b0:488:80d0:873a with SMTP id
 ffacd0b85a97d-48880d089e8mr3597273f8f.5.1790352827479; 
 Fri, 25 Sep 2026 09:13:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a355826sm8390873f8f.18.2026.09.25.09.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 09:13:47 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 16:13:44 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 24
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: 9a2e2752ccaa828668b00074c644c385fbc798fb
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 16:13:44 +0000
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a21c79c57c29129a33be31e38f4df3df83557615-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA8Yc-0001GQ-6I
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2797666499133590585=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2797666499133590585==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/Zwpb2rDNwQ="; charset=UTF-8

--/Zwpb2rDNwQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1663?usp=3Demail )

Change subject: Remove instances of constP=
arameterPointer cppcheck warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 24:

(1 comment)

Patchset:

PS24: 
Will =
set this back to WIP until we have the suppressions figured out



-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e=
5daf2b116f58
Gerrit-Change-Number: 1663
Gerrit-PatchSet: 24
Gerrit-Owner: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attentio=
n: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 25 Sep =
2026 16:13:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--/Zwpb2rDNwQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld has posted comments=
 on this change by flichtenheld=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1663?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #24:</a> </p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Will set this back to WIP until we have t=
he suppressions figured out</p></li></ul></li></ul><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">change 166=
3</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I562=
48cf6d199c2da770774b8fd1e5daf2b116f58 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1663 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 24 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Fri, 25 Sep 2026 16:13:44 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: No </div>

</body></html>
--/Zwpb2rDNwQ=--


--===============2797666499133590585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2797666499133590585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2797666499133590585==--

