Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F9ACA6007
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L+o2MpP+bfOMM0YJmf8ICYoRTjDcH2uUA8CGYfD3WQY=; b=nTLorUOPNTL9pPbDFc0tPSa8PJ
	KtMLUCgMW4cDA8ZdLeoPb0tL0Zm2Ds61SApo8O8k/ene3eZTU+TuEd7AzNlS6d6i5XfHTejY4B31T
	5Zt8NycqMINN9xdGItcUDD0haepe78Z3CejWRn79iJngBvIyH1/w3tn84FNeX4r1kq8E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEpQF-0005u1-UY;
	Thu, 08 Oct 2026 14:48:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEpQ0-0005tk-Nb
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 14:48:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Uk5kbHFY8en2eXqd55flsTMfJzOQjejJpcxuy0uQcDQ=; b=O+1/m3Q83AEu2pjs4RkM0m+4MW
 /57C/0loZmx4q83YXrlpfWV6Eh3IP4D2EwFmnlchDe9z23hyYqq0Mo6bIz6bCBFv18h9VinV4DpXQ
 mM1iVvdbhurwgmdifT0pIuwfWPLlrVUF6aEh1urzMTczsqS+BfAd54SKVHPzpyl+4lBA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Uk5kbHFY8en2eXqd55flsTMfJzOQjejJpcxuy0uQcDQ=; b=K
 jZz2dQpRLkbI5/V8ls/uUXKp03GSQbvF/xaCm3JdspaTBL6gY9yKkhgxg8AfCCtjgtD3CUV+dguqH
 1LYcjK5yTvAduVK937hSZ7OWc3eQDIGIAcW3c9YHpcd9VPrxegRvmD7NOn5wH9/4PNPMpo9io1LqV
 WWzgVPZiGZQX7z4w=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEpPz-0001r0-Qj for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 14:48:25 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso54452335e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 07:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791470897; x=1792075697; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Uk5kbHFY8en2eXqd55flsTMfJzOQjejJpcxuy0uQcDQ=;
 b=SCFYuPS01ajsvrLoZyek0NAN0l8KlmthyaOmw5DDquN/4OKylbXO89MaJE0sfDfY/g
 JHIbzMM7AusR2PKkvtsHbVEKHiTxq/4DJRe8n0Bq8hqnWxrbe81C8a4jvfWBDu3TIE/A
 9yeHtegEibLmQaiUhS5Ycq4pQFFzRZooHA3FFb0smQs3KjqynDXomLwULRxOam4FZAMa
 iMsUptBoDcGf2SBQeXu70aJ5GDrhS53fNCdrenjE0id0rsC26VxzBF1BDCphDh9ULrNi
 ahQv1xMT0TI0RYEzwSa4rVUeHsGJQw2NL1WxRQ8joGOVovWIgc42YPDJIjWRO9huk6Qy
 kJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791470897; x=1792075697;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Uk5kbHFY8en2eXqd55flsTMfJzOQjejJpcxuy0uQcDQ=;
 b=ZTEbs+QH2rICKhiFWHxB56Ln6R45m19RUOLWkO/aPYzUaufY2FMYDTZS86nhw7hUUp
 voPzS+NF/hBaiU9jFbba0OV7i8QAkQ3saRGsx4tOXO4ZtZV+np7cfymprxx6+nrj8/Fy
 pujXR6woX8PN5NMA/JFyGoW9ZXp3QhLnKJXT3KQXUxSQKCpmJX205N+21gblqxQkVnN/
 TCXtRYhpBZf8zTtsHXfvBw79u0Y4WikanqeY0vF/BbmptsxKE6LWYKk2fHzxQidHMmBJ
 0cnN7A5EICwdyEw/T1jqHiBpomOTe/zzOqskPH2sfdijU5AVNcnN5POdFXHT8A/YY9Qi
 1HmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVFIdcbJ3QYFQac7ipPd3sQ5FJ4yIc/S+CJzWBDnQFjz1cfk8rvL4ixTg06/5eiJ3GEkXXEzDGLn72zKe7@lists.sourceforge.net
X-Gm-Message-State: AFuF++luoO8zCzdyjHITb/TKn5r1i6gDeAD+YM9TG/LsU8SLuH+y8ACt
 kJ0L9dCmP0k3JQEkme3iFF23cnkbzULUSGXaFBwmpvJqywfVc7c0PqHIcDjchK9OdqkuWZnpiEI
 FrEz6nsAurvvyCb1COYfZc+7LnywNc+YOT6GWrdoEt5miTmtZr+PjMHfHUk0U8b/pvU1Q
X-Gm-Gg: AYBFou0OHSiNwmhfkJB5/b4evIhu4hNgxoG63KIhyDGzqtckgR43nA8MI6TEbjG3tvm
 2tGDQ+UCabQ4hJv3WkLC8WN7av3GDPQPLy8ls1zxo8rqW7kjLPCrW6MwxmDBAc73JgfxhupnagW
 +ih8oXQZ86vEU6b1jsfEMjJBvGAGJ3GCo+878mKKQq9TLCB7O+Y/hf54wh1juWFPSzCVNyBFuwG
 PzKZjH9QkxCGjz0CB7B47qx1eGyw/0346dddmo5ZS4cN7nKYSgkaKtLhMkdv8JW4G+s3CBuvbSM
 3hD+wQ0/7OrujDLY1e0KVH5+AZ3Dhc6iEKDbc4GieEuLPmKwmfGCKF4Jw9w2fJt4R9jkotOcQTI
 G3XzygbbdpRLQzh9YsXDzlyDl+cfXlV/Z22EtCAq3+ApL0HkEEnMUZcKtI3xPTb7oXdRZ7N5bCq
 OK0bGj3m05oGDVq9jY32FXfIvidhpcjDmZjD8FCK/Ev+70rzC61Zf04lElQutc1tsqrcSvaw8rX
 N6rwmlzRu0HNwictBmalynK9tHbhQ1FHinQhjXsHJ1QLOPjxGxcuTI+053mvez56mdKINQIUvlq
 udBwbuvhePrhsM0TBP3tBw3r/D9xbiYUESqpgt/a0pqXUkZCV2/OPALmsZBQ
X-Received: by 2002:a05:600c:810c:b0:4a1:7163:3e41 with SMTP id
 5b1f17b1804b1-4a1804234ffmr97682845e9.9.1791470895601; 
 Thu, 08 Oct 2026 07:48:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f4482c4sm268706215e9.0.2026.10.08.07.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 07:48:15 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 8 Oct 2026 14:48:11 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3cdd
X-Gerrit-Change-Number: 1987
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1987?usp=email>
X-Gerrit-Commit: f4ece820dcfb9a84c3ba309abf687f1990e98f59
X-Gerrit-Comment-Date: Thu, 8 Oct 2026 14:48:11 +0000
In-Reply-To: <gerrit.1791470166000.I47e0741c75832a8f3fe161769feb27ddbfba3cdd@gerrit.openvpn.net>
References: <gerrit.1791470166000.I47e0741c75832a8f3fe161769feb27ddbfba3cdd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNDcwMTY2MDAwLkk0N2UwNzQxYzc1ODMyYThmM2ZlMTYxNzY5ZmViMjdkZGJmYmEzY2RkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9e79c1ce5918ef273f83250bd2b06beda4463e04-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEpPz-0001r0-Qj
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Clean up
 rm_trailing_chars
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2279889624701251698=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2279889624701251698==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NOgtbkrm92g="; charset=UTF-8

--NOgtbkrm92g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Demail )

Change=
 subject: buffer: Clean up rm_trailing_chars
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(1 comment)

F=
ile src/openvpn/buffer=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/198=
7/comment/f7b06ed3_ad5c4375?usp=3Demail :
PS1, Line 606:     }
This can be =
compacted further to:

```
size_t len =3D strlen(str);
while (len > 0 && st=
rchr(what_to_delete, str[len - 1]) !=3D NULL)
{
    str[--len] =3D '\0';
}
=
```



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I47e0741c7583=
2a8f3fe161769feb27ddbfba3cdd
Gerrit-Change-Number: 1987
Gerrit-PatchSet: 1
=
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Comment-Date: Thu, 08 Oct 2026 14:48:11 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: Yes

--NOgtbkrm92g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Demail=
">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/buffer=2Ec:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1987/comment/f7b06ed3_ad5c4375?usp=3Demail">=
Patch Set #1, Line 606:</a> <code style=3D"font-family:monospace,monospace"=
>    }</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">This can be compacted further to:</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">```<br=
>size_t len =3D strlen(str);<br>while (len &gt; 0 &amp;&amp; strchr(what_to=
_delete, str[len - 1]) !=3D NULL)<br>{<br>    str[--len] =3D &#39;\0&#39;;<=
br>}<br>```</pre></li></ul></li></ul><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Demail">change 1987</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I47e0741c75832a=
8f3fe161769feb27ddbfba3cdd </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1987 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu=
, 08 Oct 2026 14:48:11 +0000 </div>
<div style=3D"display:none"> Gerrit-Has=
Comments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </=
div>

</body></html>
--NOgtbkrm92g=--


--===============2279889624701251698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2279889624701251698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2279889624701251698==--

