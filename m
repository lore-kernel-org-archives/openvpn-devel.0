Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68184CD4F3D
	for <openvpn-devel@archiver.kernel.org>; Wed, 20 May 2026 18:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:Date:From:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DUZN/QL6OvIgsX5kfNVMTOWmoY6D8JusuMvOa5/BSLo=; b=k9z4Ph8RvnAfEq+KU/OezbVYv9
	/wjdJn8kP7Qk9SfLao62eg6kH8SE50y1U749eqrCEkTH8FHVkjtSJowh9o7zwj/e3pVTfpolsRDT9
	/h01BwJ1ASM32UQA/gvwBGrxt6ETKmvqjdvuWXIGaIkzqTuRpeHZLuOrgGm3gntheKRo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPm7h-0001vq-P1;
	Wed, 20 May 2026 18:58:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wPm7W-0001vb-IY
 for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 18:58:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rph2xRy5n17UiuxSDq+JlxOuZoAvvDXGSksfH5uwVjg=; b=HPNwujU2byG+TRobd2qMI8SPrv
 S8fbZeQHIIWqBkDVF0BVrCTM7ULtYfPY8fsRiBSDA3OIeSXS9hmidWpkGfCQVTBU9fiLjoPTGchSn
 aQdbSCpThIw4ZCRqYvhB6ADFhAC9stvHHV7IhdUNk228wEQuWQWJQgSDmoJTjd7Npuao=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rph2xRy5n17UiuxSDq+JlxOuZoAvvDXGSksfH5uwVjg=; b=A
 v8lf1RPkGLvESXQBOPVL0jDkWYfuXhLzi5/sIq7sJD4z0X29T4VqD+BTmN1ffxzfqvN3ESd+o2/+2
 TthTGuLkMeAQs4MF62EJqjSpBAq3JRd0mPvrQ6ksrZscFW6mFFudcrdsNI7GBduEi1bGeOWeop+93
 +THMXW4dPpZbZzW0=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPm7S-0000Mk-Ho for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 18:58:18 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so58258445e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 20 May 2026 11:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779303488; x=1779908288; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rph2xRy5n17UiuxSDq+JlxOuZoAvvDXGSksfH5uwVjg=;
 b=Mikew7zw2aWPWL8ChjXcxRpYtGsAgYjHeekCFCzQrGMU4UVoME5qdOOT/TbnHPvJpf
 HU5QyRILTFouShVwCKQXo1vfePPkr72hSOkffNJCA1Whx725bdvktx2ufw9XsxElv845
 ZNZGDc9uLePTC6eLZcmFnI/ioZQw4tVzfSwcHs2JGbdOHFIh5bViO0jZVe61UOeTO+tw
 gF7LWrn33kAMVF8KQVaMZ/ixtqLkQSHEVfeHX35hQrxCx+7+pBNnkhc7gZ2P59P2ra0D
 9ai+2SpcppxvTGhhEKGLbwCan5e8Bfr4U9J1jDq1g6rcJh29eqAT4EUEOX0WZh4ghJUA
 0FDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779303488; x=1779908288;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rph2xRy5n17UiuxSDq+JlxOuZoAvvDXGSksfH5uwVjg=;
 b=PM3/DK9YB7Eqwggl54+NyGP1X4RVUJGGDWfrP/HFPlE2NkFGQm8E2Hzm8wiEOaCoev
 HTUrcrz65daonU3OhEj3RgGMVZ+ZISzARQTwSl1maMK3+KG1Kx4ClQrim3zKhJgohnzx
 ReXCfEVbluZ7633O77TP/RvP1ZHY4vOUcctvMJKqVOWoJCddta+LfFA43EwrofP9Y9AB
 fm0vfjooYaI2YyOtzbJQP37DlhokrDRMOVp8tFjDj1K8QTnYvoBehYNI5ai1WpKwzIpS
 Uk1osP5C2WZjaspvaQj6lqMI+TRQlpRpWWv+X0rrgz0IjuMECoc1MkpAQS0HmjiZ/lM7
 So0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ947njOeNZedaNydRtuDb1L+xjfRQIJDnGMSdohFJWcE42zfGxmPuGg2EntOunqSkGSDTM0sVFy0ARJeHnX@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwXl3Wi+wuMj58yCmm5AlGBJV5fU/L6srEqWhI+5EnNmAfuJoH1
 F1UmjgpRkaDTnDw50KsVf4z0ucj6oCFCYLILMdP1PnTOpDZXpOl/Ds1UPtQQ3rAG6rOecH0/Pwt
 xVvJsFg5biSnf5TYAhe9yUb9gHBa37Fyp0mg0TddTmmlINDEvnz0ggGJesg4e5BBQc1Kn
X-Gm-Gg: Acq92OFULm/mwRsBJXDi+Vwk7SmvGcslWGG3Z2/aFb13OpKdQOQB3G9cwD60JCQOD60
 WgfzsaiBao78ORMfYxnviplv1mslj/DrYEEM+QAUomkBMYWSBPyJp3/in9mPwOoFbPtCd9QE3hW
 5M/8g/VJVcUJDwJo2dlsXBp2o1/nhVxWG6HpPZvPNa/OgRJalvSbR1LMIfwhzgROWV6NCTAAUGL
 vK214MU1bLZK2NF5CLLdHwVP35ntsQ8XubpkbhFRtJfUMuZd7m/uIFB2DpBnI8G5S3EyciatkOq
 pP4DIDAqJWXLb8FLrAFlwwhLkZ7iJux3q8VGjBbII6dA6Zy9XGe3fR8bPzyIVlyM2Kgb5dxHV0N
 1XktRC7hDYP90HeyQrjUfecKTMUnSVuAWaf+MsI1TY/syKWe8iytjHyPUlGFBhK+L+U2wW1LS9n
 8eRj4xmX9k+MPRZDrDtQ6BU+9D3WJAZS4dwIyDXvEr1JOWtYv6xw4+mS/ao8bTlRUPsMY5slB+j
 845xutPkKn0eLJl/WzHrW+lbEMfhjP5RW7l6Z1hhUhwHmkiuQVfn9Ms2zfYLVdd0ov57YG3eZ8f
 K4IkAz0jZT1EZg==
X-Received: by 2002:a05:600c:34c4:b0:48a:89d9:a419 with SMTP id
 5b1f17b1804b1-48fe60ecdafmr412449625e9.11.1779303488412; 
 Wed, 20 May 2026 11:58:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2a878sm217042935e9.1.2026.05.20.11.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:58:07 -0700 (PDT)
From: "ordex (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 20 May 2026 18:58:04 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
X-Gerrit-Change-Number: 1682
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1682?usp=email>
X-Gerrit-Commit: c5f02a68b6036a8c30e5e81704b1ffa417b26d83
X-Gerrit-Comment-Date: Wed, 20 May 2026 18:58:04 +0000
In-Reply-To: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
References: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkliNTgzMmRjNTZlYWVjYTFiMTcwMTYzOTY3NjliODRiZGYyYzE1MTNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bca8020e05d06b8984e9be8eaa71fe727dec80d0-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wPm7S-0000Mk-Ho
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi/dco: simplify
 dco_delete_iroutes call chain
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
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6225109263378013395=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6225109263378013395==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WwB8gOcFaFs="; charset=UTF-8

--WwB8gOcFaFs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

ordex has=
 posted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1682?usp=3Demail )

Change subject: multi/dco: simplify dco_de=
lete_iroutes call chain
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 2:

(1 comment)

File src/openvpn/multi=2Ec:

http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682/comment/b5238754_9426e20d?usp=3Dema=
il :
PS2, Line 4378:     struct options *o =3D &c->options;
> If limiting t=
he argument, why not directly limit it to the options?
yap, that makes sens=
e=2E I went for context because that was enough for me=2E But I agree with =
you and will pass options directly



-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1682?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
Gerrit-Change-Num=
ber: 1682
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Commen=
t-Date: Wed, 20 May 2026 18:58:04 +0000
Gerrit-HasComments: Yes
Gerrit-Has-=
Labels: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--WwB8gOcFaFs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1682/comment/b5238754_9426e20d?usp=3Demail">Patch Set #2, Line 4378:</=
a> <code style=3D"font-family:monospace,monospace">    struct options *o =
=3D &amp;c-&gt;options;</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">If limiting the argument, why=
 not directly limit it to the options?</blockquote></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">yap, that makes sen=
se=2E I went for context because that was enough for me=2E But I agree with=
 you and will pass options directly</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail">ch=
ange 1682</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1682 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt=
;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 20 May 2026 =
18:58:04 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>

</body></html>
--WwB8gOcFaFs=--


--===============6225109263378013395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6225109263378013395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6225109263378013395==--

