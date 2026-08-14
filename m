Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A1AC5CFDB
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e6oD2Qg3JhK4lQNAcs69vpl9djpsOXgxzycfmfiFCrI=; b=TqD3yV7FHTMC8Mmnd04Mi1xn72
	6A4IbtSqsyGr+CS7L/CBtwipbJ5m4GjgHJW1en2p/EEDeEOpzAcWfAxKWVF+ZKtlvBMOJCBqqHu+G
	j0EsyRYuOmzSfdl+8CQeLuaXwwX4m40gp8LNDYLjurMQHkomuGOxSOSwVu8UTRBld8rQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuqXE-00085l-91;
	Fri, 14 Aug 2026 11:57:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuqWp-00084i-RC
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:56:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gTmUbLgz5YnfJNTr6GvxT8Zj4txDTlVEpdtyx27+A3Y=; b=WLUSbtfa9k8wvB7QB2kCsuWNxk
 doZK+KeRp6GHbkC0PTV81k0pT97HFpWSwoZrGgyDSldfLituy4QSfezZBIY26+bCfeLgUXKnBIJ1E
 Pv5OodvfuqHjWoDkpePHDkYpUob47JstexBW85CJIBs5zUjNP8fafBHzwYdKCP9NfngE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gTmUbLgz5YnfJNTr6GvxT8Zj4txDTlVEpdtyx27+A3Y=; b=c
 ZLxiWviT2J9/mfOHUmoGnctqyF4AKrhEFqYy7Fll9bTEXQ5bvDf5bAWz9WxJHVToXhjC5yMaCRj4g
 WycOOqIgXVhb80SNARPK+N9taR2dkKeoMBgRavWHbuC3VzLi9nufUf5EOfCAiiRsH9v7hGrn/7v+B
 UrbXPc+a0bfGBkpM=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuqWn-0005qZ-LE for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:56:47 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4815b8781c7so415154f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 04:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786708599; x=1787313399; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gTmUbLgz5YnfJNTr6GvxT8Zj4txDTlVEpdtyx27+A3Y=;
 b=FjqOOZE1Pgx/hOmdBnEBWbOepgpHZ5UByCtogKpEGv+kmk825ZPSKNJozzbCTP2uuu
 0xhbM4SPk9b76lIUIRFiK2rN1OXCfZ/pO5nCxtGjBvqQ38LZ7ZIonx3+4B/jV6SqLvDh
 9ZOY/sadzrw3PEHawfaeTT4UusCcLAi035KKudG5rLRrdGnrhDw46BRhfW4cxcC4CvZu
 X2kcrbO5GIHa89/qmZy9x68YScvTARC/eRkHSIcTJxBWwtoUOPHjT48hhefcObu/e6Ot
 qXXj/GR34gpSeWB7kM9sjq88RxK+X9k2E7GKjUbMaUSlqy4K/Bwn+GdYZQfXREHoQgLj
 gdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786708599; x=1787313399;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gTmUbLgz5YnfJNTr6GvxT8Zj4txDTlVEpdtyx27+A3Y=;
 b=lZIHUobpF37SC4p7aHcnfvaLafovupOw+XNRoNrqYDFNngVJsy3BDMRTPbgIjIKefP
 NjODnaBaGzhwQnr/N1ajhSGFL1lh75X/3pItVzQzDKSJiGo+dfCBVGoBq/SMWMfHzqR/
 1zm0Ps4ormURNSGtzd8+gmX2dc1YbGJ4f3ZrQ9ZcdsiP7wA4jPsaqlNKs8gpxeMVrgV5
 TbJS8z/quNU1Ghp6PHpm9696jmfvSaXzd/7QwHQYvSQE0YoR2PaO757a09fCg6yP7PXW
 LowELhaWoVOHcFgRvoo5DnCB8e8t2iJR+oCzHJl2R2DPJzQnmWI5bW8pz/aaDEbiabal
 vLwA==
X-Forwarded-Encrypted: i=1;
 AHgh+RozzeoLwPYCCT7zv9hdBKkVbSYuTtvDXo1YVA6eMi8oVADQWLRbvgzXXGGSRQ0JnlIQGX8EWf3kxSOwTDhp@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy8sRSY3sR+T45ROtH23FYfBAQQQY2VzgIkcAIr5lyID3/9oTTq
 RjhiN0cANo6mCmy2VqBe74xHeD0FvHA8j+C15FUHtnapnFm+MmgVkWuuwhAwno4PyBPmnMP3mlR
 EuC7rEQhIOwZtvMJEr5sP4lhrtZ5njXvwILuMJmeByuykMLvVXjNSBspez1zEwxOrml7BPCMbnR
 r3959eHg==
X-Gm-Gg: AR+sD10WCNZh/N67IL7k96d/fh+wzgsrXjJR6yAf5Cu+vUQSqV1Wy47l4UNbBxWbBJ3
 ueRFzZOUEE0LmoWovdG3EyZjM5I+lJAxgTSmJ6fhOjJNcybY1E+sW7LoqmhfVTkQ1ZgDE58z2kA
 FYrxIhDyPShhjb/rc7KICrXgxIDrLmhX/P4dSjNAFGVX9F50ET3ZrqHMA6PyBEIVOtNQXfHFBKq
 iSPdWwmQxLfpBBGK9GzHBGQMNPhcnwzWhxL1crxZI422yAwv0pA6qP8npQzkbJCjKeYRk39eX2z
 q37Ye1kn4Ltq4+FpxFz75RcXvimHyQaaUP/vOTClwDbpOsW9WPO98zKbEPKIna+GNVuxtlcPYxM
 qUJLhD1Wv6hKIozX06lTcpfLaSHQtikca2gLDtPTIQZYRGt0wswWGw0Zk/Tpaj5ogYVUrhwDmgY
 mFQacxhdMYUpbrn5L9ZaXPXwRKtDfjYLGGlUQJnnjkNAsjjQSHWvT9jcruYln8+pKMZSKlvfb/U
 DBhpt0c95ZCUMiiA+17PTBtSNuZbTDpcDI/Ry5jCOE75uDSMQN2Ws274ZxzoD5MfhZ8Zsd7QeT2
 wWr0bPYaB1rU2O5kqV6ZUVWITC9GbPf11Qbvqpu1TVBUyVvrMk0=
X-Received: by 2002:a05:6000:4917:b0:47f:8f8f:db74 with SMTP id
 ffacd0b85a97d-48160714b64mr8424367f8f.12.1786708599410; 
 Fri, 14 Aug 2026 04:56:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f20051esm8364499f8f.7.2026.08.14.04.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:56:39 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 11:56:37 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
X-Gerrit-Change-Number: 1826
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1826?usp=email>
X-Gerrit-Commit: 217af18cbca9c5fe2aa6794c9f4f6633f150205a
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 11:56:37 +0000
In-Reply-To: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTU1OTgyMDAwLkljY2RkNGNmYWQwOTBjNTY1YWFjMjdlMTZjZGFhOTg3MTEwNmMyZjg5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dec2bc694af9dad9bd6332f7f6f46dadd49850dd-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuqWn-0005qZ-LE
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make required action
 returned from pre_decrypt_verdict more explicit
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4678955110948349587=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4678955110948349587==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LQYR0KbD8G4="; charset=UTF-8

--LQYR0KbD8G4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, stipa=2E

plaisthos has=
 posted comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1826?usp=3Demail )

Change subject: Make required action=
 returned from pre_decrypt_verdict more explicit
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 6:

(3 comments)

File src=
/openvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826/comment/=
0e5c043b_23a1402b?usp=3Demail :
PS6, Line 219:         return PRE_DECRYPT_C=
REATE_SESSION_SKIP;
> If I got this right, before we returned FALSE for inv=
alid/missing SID or wrong pid, and the calling  [=E2=80=A6]
Done


http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1826/comment/88ece37c_ae307f74?usp=3Demai=
l :
PS6, Line 249:         return NULL;
> here we leak gc
Done


http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1826/comment/0994f11a_6c2811e3?usp=3Demail =
:
PS6, Line 280:                     mi->context=2Ec2=2Etls_multi->n_sessio=
ns++;
> previously we only incremented sessions when we skipped to pre_star=
t and now we do it for CREATE_SES [=E2=80=A6]
No=2E That would count it dou=
ble=2E Moved to the if clause below=2E



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
Gerrit-Chang=
e-Number: 1826
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Commen=
t-Date: Fri, 14 Aug 2026 11:56:37 +0000
Gerrit-HasComments: Yes
Gerrit-Has-=
Labels: No
Comment-In-Reply-To: stipa <lstipakov@gmail=2Ecom>

--LQYR0KbD8G4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, stipa=2E </p>
<p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">View Change</a></p><p>3 co=
mments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1826/comment/0e5c043b_23a1402b?usp=3Demail">Patch Set #6, Line 219:</a> =
<code style=3D"font-family:monospace,monospace">        return PRE_DECRYPT_=
CREATE_SESSION_SKIP;</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">If I got this right, before we r=
eturned FALSE for invalid/missing SID or wrong pid, and the calling  [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1826/comment/88ece37c_ae307f74?usp=3Demail">Patch Set #=
6, Line 249:</a> <code style=3D"font-family:monospace,monospace">        re=
turn NULL;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">here we leak gc</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826/comment=
/0994f11a_6c2811e3?usp=3Demail">Patch Set #6, Line 280:</a> <code style=3D"=
font-family:monospace,monospace">                    mi-&gt;context=2Ec2=2E=
tls_multi-&gt;n_sessions++;</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">previously we only increm=
ented sessions when we skipped to pre_start and now we do it for CREATE_SES=
 [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">No=2E That would count it double=2E Moved to =
the if clause below=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">change 1826</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iccdd4cfa=
d090c565aac27e16cdaa9871106c2f89 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1826 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6=
 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Fri, 14 Aug 2026 11:56:37 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body><=
/html>
--LQYR0KbD8G4=--


--===============4678955110948349587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4678955110948349587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4678955110948349587==--

