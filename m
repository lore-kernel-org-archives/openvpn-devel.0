Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D19CD4F21
	for <openvpn-devel@archiver.kernel.org>; Tue, 12 May 2026 21:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:Date:From:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X6Ffd6M1chh7ZFKn2fUv2PUe0C5o0b1v333f+oQpGhA=; b=H+LW6OGmuc+7WoI49EkZjsi12H
	EslFRJYdNnmsaDPSZ9rYngPkrSGnsCebV+q1gGfXkt214zYqhr8ce1TPHjkxNr2+yKdfNXV/740CD
	O57jdwN43mQA7OxZXX5ckbLndf+5vKNTGt17mm1hIVPC/2xX6C5BPQNvEcj+u7//zQmo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wMusJ-00027S-Oe;
	Tue, 12 May 2026 21:42:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wMusJ-00027K-5D
 for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 21:42:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Vn4EHYzi87S+HKtjhpNqUGdBpxuOUZ36cG1AYyk1xHU=; b=hc8PCOVbv+8HyCRr/JtOWBVhgC
 ozcrU8+dRbESkyVbQZxQgnmxx2aW/XvUTVnChYqtJX3xM2EH+5LcPL1kjaO2R3ReFrnjO92P9TZRr
 6ADuOqwxeXZlPpfoMxGHUKCyri5k1SeOf0bWTwwf/yYJXfPxEUlIe08TQOTONsfr34SY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Vn4EHYzi87S+HKtjhpNqUGdBpxuOUZ36cG1AYyk1xHU=; b=i
 A3EPFGnkbPrbKYaqsr7BMbaE6BmoCYPX5vuOpodtpPKIx1Q8WA58p/mSo7zq8mk8jcirDUnKNh1vr
 nPKyh6wej8UDfvJJjiYVCB6PQZ+neRADEiKvJGoMxcfcEbrVPEZE1X3AMXpIlbyuiTZKa9uPhWvt8
 Pv9L4JgQwvdQxE4A=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wMusE-0007lm-Ib for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 21:42:44 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so24474995e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 12 May 2026 14:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778622156; x=1779226956; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vn4EHYzi87S+HKtjhpNqUGdBpxuOUZ36cG1AYyk1xHU=;
 b=eO7ukggU1A98r83e7Adb9t9B3xGPywfCVGvAEBpco1PBNvpGZhoeZyMr12/wRtsBJ+
 1HZrEUm8RFvpOoAS+xjCK7i1UY5dwiIiALQgRW+mcdlnfs306IuKSMkSdN1j6SnmxYda
 13GDdgy20OjE2ueIB6g0iO+s/noeikerISyXx/CNSHq/bDF3EZw3+UMSAt5f5C7m0aiH
 g3/NJxqiUjepAWePpKDP3hya3Dz3o0GMYr/4FEbefNaJLUwDuzIExibZqzm1IQdgnTIO
 rZdWZvSyG5cSZYkWr3OW1/Hcc9KDrXmZxgknVgOqi2QUcuDb/gYV04O++bBskV2K35/W
 5WHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778622156; x=1779226956;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vn4EHYzi87S+HKtjhpNqUGdBpxuOUZ36cG1AYyk1xHU=;
 b=eEpBRd/+eD6DSI9Tda7j3E11ggyU2C3wNVobsOvJCxn1/4KZZFOK8YRoE0lclaNHZK
 tvP5ZWvVHikEKi4v0IUSBkT/ZwBhm//bfd7y7pt2+QpjFS1rGgEvBT7lG8IEyzQXf1Wu
 GttF8Nj2JFYvRjS3irDfdSi9oZIgbnZHrN55vpomSrcGdD/DJ8FqADKsT9Q+WubjZxKR
 KfzEn5u6HK4SsE7MUcShT5XOuddmmj45AoLINHaUDyB7OP1Z50CWkCJpJZKkbva9WRI6
 CHXK9f+4f5hrFZKUHytfYay0UnGtgYK78ch5eXrmNwhY9Q2Vd3WOsf8ctkQrVFQa4n4z
 779A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/rN+o8coPKTDD0CZucMdYv36zGgphBLLrDqgxdzIhVgBBqGkhR0HnDXxzKAsV1njJIDI6ccClv4GzVU3JZ@lists.sourceforge.net
X-Gm-Message-State: AOJu0Ywmf04efceUX8/NGalANEXXEXC0aJCnhhFZF8cYMNRbJRr5JatZ
 NkOBpjQI96eU3FEPzuR6kq4C9tMQajbiGWLpWf/C1AxMXW7b3baXLpyuj6kf4KTHDaI6bHnLDwi
 t7f8gQmpXraWEr959B6r5nmu60frNB47q1DAzzVfLej4zkkqrM/x7JApsLmMAeldg9dVz3Mz5Wf
 II4l1luQ==
X-Gm-Gg: Acq92OHi4/egNhmWRHFQOR9ZVSaF+PEA2F0o5bz4pybJqJcZZ+emEUK7XSrJzKNX0Ux
 mWNygGm/YasBg/Wl+UQSjmhshaXkUPMTLBnSKFJw18IE8q53p7+5m6SuKHU61NI0XUp5fSx8EDG
 G64O0jyn3B9L1Vlhc7xfEwfKMu1gjXOl/kOh6sK7f11MHmFM4I5EaU0yUeKYBx6FhzLwFCf9ITR
 tL6rI6GRGpXQtYz2GLt5DXW2hIs9Sscl1w59bj1UvmX+IGVv32bTLe7ZCf4ufYIVVprmicH99G1
 c9qBpPNpXEfFE9QKOyxKChwY0SAf/9G8rVsPl7fEJc7pFNXrUfOQDRFvcsTWEJnXuOJwXDFCmKX
 zXigcn5XS5a2vOzIZMj01bYvsDNbCADUwgaJb4MCLStpJHM4Yqyq6tJ6Mehl63oNb0Bp4zl7RHN
 nWZeQbiEbcPKsFgKhRj8hGLUwtyVbMd9S4u+h/dOsz026OxoGss1FDUmOE/k6RdbreSEzLGLmKi
 0zgSMYkZFgKJOPp3IDxwdf5qBS7EryB+QcA10Gi+OGQ23XfHX3BBkAXFo9Oc+Dfu00Y1IVldoVB
 y0arBRxbgb4P0A==
X-Received: by 2002:a05:600c:34c9:b0:48f:99a9:bbcc with SMTP id
 5b1f17b1804b1-48fc9a0fb96mr8969955e9.10.1778622156374; 
 Tue, 12 May 2026 14:42:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fcdf6408bsm1782845e9.3.2026.05.12.14.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 14:42:36 -0700 (PDT)
From: "flichtenheld (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 12 May 2026 21:42:33 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
X-Gerrit-Change-Number: 1675
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1675?usp=email>
X-Gerrit-Commit: 4f2237d6290877fda67a6c17e34f293c0ff4422e
X-Gerrit-Comment-Date: Tue, 12 May 2026 21:42:33 +0000
In-Reply-To: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
References: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLkliZTdiM2MxNzE3NmM5N2ExY2JiNGQ5Y2M4NzczNWIwNWU2MmM0ZjQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4f630d3e8da2aa9d51a5f4a5572dd3d2d816cda1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wMusE-0007lm-Ib
Subject: [Openvpn-devel] [M] Change in openvpn[master]: lladdr: Clean up code
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2444547254107496350=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2444547254107496350==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BTutiC10i64="; charset=UTF-8

--BTutiC10i64=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

flichtenheld has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1675?usp=3Demail )

Change subject: lladdr: Clean up co=
de
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 4:

(1 comment)

File src/openvpn/lladdr=2Ec:

http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1675/comment/b9cf9909_24e8b4e3?usp=3Demail :
PS3, Line 38:  =
   argv_printf(&argv, "%s %s ether %s", IFCONFIG_PATH, ifname, lladdr);
> a=
h, here's the culprit=2E=2E=2E [=E2=80=A6]
Done



-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
Gerr=
it-Change-Number: 1675
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit=
-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
G=
errit-Comment-Date: Tue, 12 May 2026 21:42:33 +0000
Gerrit-HasComments: Yes=

Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@greenie=2Emuc=2Ede>=


--BTutiC10i64=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/lladdr=2Ec:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1675/comment/b9cf9909_24e8b4e3?usp=3Demail">Patch Set #3, Line 38:</a> <cod=
e style=3D"font-family:monospace,monospace">    argv_printf(&amp;argv, &quo=
t;%s %s ether %s&quot;, IFCONFIG_PATH, ifname, lladdr);</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">ah, here&#39;s the culprit=2E=2E=2E [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1675?usp=3Demail">change 1675</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735=
b05e62c4f43 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1675 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D=
"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> =
Gerrit-Comment-Date: Tue, 12 May 2026 21:42:33 +0000 </div>
<div style=3D"d=
isplay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> G=
errit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-T=
o: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--BTutiC10i64=--


--===============2444547254107496350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2444547254107496350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2444547254107496350==--

