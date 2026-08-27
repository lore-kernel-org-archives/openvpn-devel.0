Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEBFC61DC6
	for <openvpn-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BLaryhcwlg50WZ0SdSjqbtLKst8v6vGsJjz3wwsEOmY=; b=mfBAyaw9s3RQvFsWD8F2YVbNZJ
	sREiRaIiePPH7wj/th8Nj1KBMyyHyMD1ITNYYfS9AmbZjlHyXj4cF6aJfyUeG+H2Wu8ygGfreRJ91
	dRSflAbR/z6oDanXrPpTRch9wWg3IeXghJAkSGytUus0wmszAXrJvit2sZXOrAA4Fl+U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzYZo-00039q-SW;
	Thu, 27 Aug 2026 11:47:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzYZY-00039a-1o
 for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 11:47:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vNCiy4XrcKp/GSnYKCWevsZUNWoVsy1pL8FOraO+YEY=; b=OJWNb4MrboRsbUeu+m0ClKNkAZ
 QhJSJgCJIEIKce0M2t26bbm0ke99Gpy4lDAEkxh3pio2mgIKoKdQ3C0pBJ85Sr1QzkYcufM8OAr4+
 ntHYwkMSDI6weesANc4+XXz8vJ/nDCeKHeUKzkG7dJngy8mitU4Jh2p26mv4QwWaw5mY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vNCiy4XrcKp/GSnYKCWevsZUNWoVsy1pL8FOraO+YEY=; b=g
 82wTXuxQ1cytz5RCLW4vlTxMYs9MQ/kH2LCodLuCBM/TkDhmkVcNp1j2qsabSZIJ0SfEPAOmaxvlW
 boS9+2EcOkhnqn8HY0Y5Jx4AwHV8oDEa3o05QuLHzrQ8bOTdTW+6ESUckmIkFEKCkPVA6W1bea6YS
 u0c6eWql/rsShOm0=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzYZX-0007MJ-D5 for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 11:47:07 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso17058135e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 27 Aug 2026 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787831221; x=1788436021; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vNCiy4XrcKp/GSnYKCWevsZUNWoVsy1pL8FOraO+YEY=;
 b=H4g6g5VoJK9auQOnv9LhrL0taq47NsdQ1Z3cU3vB5rWOkRILJj8ChMfUjyS7jAr5+t
 U08H7d6AGkUC71iEDVazd+luLFuNMYXvX+ezkEq0YFbQWTPhtuvR6b2YQ+qdQ7FDWF/L
 9/PgXMYAmjfYrrqGNX6VnC8QJ0B+k0JoUayCzXxhVHWTeHaMz4lTlkLpxD9x/4V4C+nf
 0B3bUF2BPdiRf49beioy+HudreUAmmrgl62nAOv5OQ94kFz7ktYL2dfOj1OcrAP7tsOU
 8Kcn7ibj6qECfTUJv20S058bqtzCmZgTdlPFAE10V1V49KIffw8QhHWw1ofASuZDazNz
 k+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787831221; x=1788436021;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vNCiy4XrcKp/GSnYKCWevsZUNWoVsy1pL8FOraO+YEY=;
 b=D4TcB5XxCxXijsxYLzzF9FNYzMuuA0DB9qCqo05qPMu2OJS+1xziCzs9umFF4fu5tm
 CQT+yZIsFBy0dGAlQMVL56Fjo8BxVnisx7hbdF2NQVEEL54qGYGxqxnzl0Wm9gpxNJ+r
 gQ6vJ6zH3eLOxDkRmptT2V2/3c14JnMqDhJnvAc9Zptup5hUe5MceEs3Q/U3Fpsi87DP
 4MpFS6A2ADlAWXBjCAteHUlBHFtPi52bjmPjsrLQkefFE5s+z9pQ1y1oLrf2N9OvscBy
 bhowhLH/+h6HMPjwG95XMMfGlM0kr6h7q9ztpJEIcPlrboV3JCSstSzRBqCRgPinlkiD
 jbsQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpX582vVNs6Lby296ftRlllitkMRSpbN51a+f+n6NHG1B/ehkJ/ec6HVtweVE2uXk9+7gILQn8DGn2grbpO@lists.sourceforge.net
X-Gm-Message-State: AFuF++lZMDHACUYdLerd5NMY18f4HHWeqBpnBd9MLiNKA1JUoiYdKmfk
 Cq/zAZTp+cyfXki5b09Xco3EjuMZqISs4D2bpMrnaz/mM/RrpYFx5VwfFk5BO/IcaQ70gUykTKj
 CcvrusuelZxbb0U5q/9BKlENFs7/eG5N9Ii+6o9DoRLn7jrtUdZcW5ZSumOx2shoVCFJP
X-Gm-Gg: AR+sD131GXptTCxTCkvRm+Jf6N0SztYjUNDGnCTX4P5dHLPnNi/9p/sczlY2FSo7BvR
 Dzfw75unpUXAusSdKZHncYX+ZqtuW+e7sBp8BWR4RFkNeQJqoCRpBbO03py92SqL4Pbz/ORc/J+
 aBOHwWjqfBxfigFLCuXejXu+bVgClkTNTOtyo/S3+yTqG/O3RwzaNdqs2LVkADmQOtwv/zFEHH/
 nkpEcLO47acZAHm6hCUEGFFFScbkOZE1zt0VbQhvQb9GTy+NJTQcA607IUIX5IO/Jvcsxz8ZC5N
 eXeJ+nJxEZtR9zxTPm2C9JFxu9N984FTDvV7v2f7/4rbwvmBFedjuPqreT7AydmHpZLFXIz3PUI
 5m9SmSR4Yi0NFezfHcnQgbj80t+K1sYV3IGSwCbaij5WcMAn3kdfK76fWkk5q20SC6KjALmEBAH
 F/bEN8WxFCbFW/OFxYThRWR7UqmLeoMT5IYZxNrwJRHNxkkdhCIjmWpdN1vlr+p6fpWDVOhc03C
 YXVyhf1UZhjWiHut7/mg27/AacykH8LtchLMUSpw692iJWE0avvmt1P/ei/WTP6DV8c0kMQkqu9
 TQZTQSCgW+wPXoPibE4IzyV0z/SCSApt5Sh06VFL/T4RZ2vJ4i8=
X-Received: by 2002:a05:600c:c4ab:b0:499:a8bd:1930 with SMTP id
 5b1f17b1804b1-499dc6ef59dmr154690355e9.5.1787831220566; 
 Thu, 27 Aug 2026 04:47:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b8d2ba486sm24944755e9.5.2026.08.27.04.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 04:46:59 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 27 Aug 2026 11:46:58 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41
X-Gerrit-Change-Number: 1763
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1763?usp=email>
X-Gerrit-Commit: 623e21dfd7d3e47c5d301851b6154b0c743e6090
X-Gerrit-Comment-Date: Thu, 27 Aug 2026 11:46:58 +0000
In-Reply-To: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
References: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTMzODUyMDAwLkkxOTA1ZDk0OTQzMzZkYTRlOTFmMTk0NmQyZmZkODc1NzIwNjA1YjQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <859c9f9b5c2f4763beb8c769286a52296534991c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzYZX-0007MJ-D5
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in: Add
 utility function needs_openvpn()
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5288558000378389098=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5288558000378389098==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gP1I5BbJ2AA="; charset=UTF-8

--gP1I5BbJ2AA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1763?usp=3Demail )

Change subject: t_client=2Esh=2Ei=
n: Add utility function needs_openvpn()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(1 comment)

File tests/t_clien=
t=2Esh=2Ein:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763/comment/e051ae=
49_ca024048?usp=3Demail :
PS4, Line 68: openvpn_version=3D$(${openvpn} --ve=
rsion | head -n 1 | cut -f2 -d" " | sed -e 's/^2\=2E\([0123456789]\+\)=2E*$=
/2\1/')
`\+` is a GNU sed extension: https://sed=2Ejs=2Eorg/help=2Ehtml

I =
don't think it will work on BSDs (and probably macOS)=2E



-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I1905d9494336da4e91f1946d2ffd87572060=
5b41
Gerrit-Change-Number: 1763
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Comment-Date: Thu, 27 Aug 2026 11:46:58 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: No

--gP1I5BbJ2AA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File tests/t_client=2Esh=2Ein:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1763/comment/e051ae49_ca024048?usp=3Demail">Patch Set #4, Line 68:<=
/a> <code style=3D"font-family:monospace,monospace">openvpn_version=3D$(${o=
penvpn} --version | head -n 1 | cut -f2 -d&quot; &quot; | sed -e &#39;s/^2\=
=2E\([0123456789]\+\)=2E*$/2\1/&#39;)</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">`\+` is a GNU sed extens=
ion: https://sed=2Ejs=2Eorg/help=2Ehtml</p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">I don&#39;t think it will work =
on BSDs (and probably macOS)=2E</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail">change=
 1763</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I1905d9494336da4e91f1946d2ffd875720605b41 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1763 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 27 Aug 2026 11:46:=
58 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>=

<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--gP1I5BbJ2AA=--


--===============5288558000378389098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5288558000378389098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5288558000378389098==--

