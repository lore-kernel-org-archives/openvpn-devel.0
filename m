Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B72CDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k9ggxpURfz2dVYVpephXZWQC6mR5RtwM+aWIOtbt7zk=; b=Q2Gw67SuEXTAVhK5Xc7vk4bame
	F8PDbv/au763dCV0lAgcCAsCaV7FehzKM9MVkE8MwE+JmHUwPDP/REBu16Cemsgi5xvQGgGGZzHU+
	hUhsCHqqzxr75mRR09wacZPc7Vb8qDTjMEOlDrHZLGcYHi+mCav1WNGAGH2i0e8aH2JY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbfCm-0004gy-CD;
	Mon, 22 Jun 2026 14:00:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbfCk-0004gq-HA
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 14:00:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=03nSFlLEqA71qWwIlrPAHIqTjwlCaT5njrI0DZxu8TM=; b=QUDsUjN2qe5Dc9UObWegSZcGiW
 NmLKbcWQhjiGUdkccnnIqgVjJgsnrAwuGxwK1pw2z7HQCW90845Y+VwwTWR0TY4b4sQJ3UVSxWyuh
 Mv+yiYYw9ZgdKpshL6daz6mF1sZZmaHLugyGoM2e3TfMW6YIw8FxIjZQUrPZWT6+UdpM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=03nSFlLEqA71qWwIlrPAHIqTjwlCaT5njrI0DZxu8TM=; b=b
 2WFKH4eXr/FgoiwYIQ/RBStjpGXP3RTA3Al3FI9UPuDcfQzFhi2RZXwWZk3KKBiFAEyOvTGbCSXIb
 V3Lf/GZYUkWRAekVIGR1upsQiXaJXwm67GHv06ihN/KoeVB3msjYiAkuaiCOVIdhLK4Nk6RW9R666
 ayt8h/zzXRTADJr0=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbfCf-0002hu-Jw for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 14:00:48 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-462342ac290so4951226f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 07:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782136839; x=1782741639; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=03nSFlLEqA71qWwIlrPAHIqTjwlCaT5njrI0DZxu8TM=;
 b=ADE5G+Zc2UMw/kmEdnIkyqdayvJi739edMmrCOPNdaGp3ip50oOk8+OtZGOERGcYe+
 CcOv6xM9fPt/5QlDjaWwDzyiaVrse7cBx2d/bOUm7E8cUKdjBmzakarfujaXn7ZE5JPx
 arJ26ZuuFMQ6obmYOyjiir/2qOQblwFzugQfswNf7+vVUmB2UBKQj+A4pD15C1TK24FN
 vcPeBVuzAWXv8AP4bHVE41rVzQ5pkDVVwyOXEHVgC96GYAW8PMbHXIkXMbG0DV7DIZhs
 vQO0q4UWmCO8YsNSp5bLTdWUgK3jNmGQ79qVl3k/9by2KmvcWCo3RX5F1dlZUM2biY6I
 tzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782136839; x=1782741639;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=03nSFlLEqA71qWwIlrPAHIqTjwlCaT5njrI0DZxu8TM=;
 b=W694CFnLuHPW005MUIUwfILRssUO6Af+6sW+bqkXFMDtR4XWtflJ9hFLw9JibswdZ3
 onbcFU4KbcdC/RjndnHJqtu1YLNEJqAs1CPLLs7O/7oQnIqmYBf+Gy7Ps/MxvG+p6aXa
 3QH6H+f/23QI+gbeEyqXmPeaoVt/6gTOkWmlkBMRlfL64gzouYsZNoi70ZmveIWzh5gK
 m+yz8kLsxTe34IyYvorkbaYESujdHWxN+55A+cEOa61guVtx+FoyOySYt6BvL0IUBeLc
 GZfQ5LrFa2lsZeu/RIIMYQbMh8fkzzVtzOmFQq6MJQ6K7TOD5XCuQ6g7RUKphEhwRPg6
 wxXg==
X-Gm-Message-State: AOJu0YzVHrhlngqwa9PyXs0ZLyJXOMstD2MfG77MMu8XWyJ5M2CIHuLA
 7bXoYHNIpPECQ11YKaI6DALv09NrKv5Y3gNcK4CMz+4u6CfxBw5Z+httelcar2TkvEW8FG5AJ7v
 oFEAllcjghf6/vldmUPBwiQPC6PF/KrBCXv/zuIqSe29V/Limvsby8c+jmkrZQYxD9N6IZyRtdY
 IYfWvn9w==
X-Gm-Gg: AfdE7cnnF2xjtt4OPaqVNsQ0gdU7cPTrW1zpQRRMkGCOZN3pQRqxtK2I+7AaWv033Kv
 GX8ZDKagollwNWON8uoSS5+8gm4ydMOZWNEZakmeNhCcgqHxuQyNwKiIlGZzqgONyoZdwzhY3a5
 fmly0UElAUyOhv3krp8W9WvLpRtT7S/ZnvrQaHwBrH+U0I4IpZ8/ZTAgUzN0m1YYrcf+7FdUgYW
 54qHUgJwHD0ITdA/sV4zQviIXIdDjhPdxNXHnY94zSOgejoCIiC2ZB3SeiN7WW9/4hRrXsFUEQz
 ErR4OwC45fKueMxBwcJAUflCnDIRXHCbIiny/nYJus25nSOGsG2t0K9Eeps9/MX2DSYSFlwauMc
 s8m3iOz4lAM+rjI9hPjMykHfGUwz+CY2c0s7U/wMdcpnb6/kuNsTUPvYMnSGgDRKoPI2r+YG34s
 Ghg7O4lDOIXfyK8U4WI/V2TS64x4pUX/i15IdT5tcLjEVABv/56w9xX60ERom2245Mc+ocNJozX
 AlUeklEvqz3UkT9xvf4sg4MU2spABpNEtInLiQB9w8peMgLfblqQ6DladFYrGdV+lEwIHtthRQh
 Tgk=
X-Received: by 2002:a05:6000:4286:b0:446:db72:e8ec with SMTP id
 ffacd0b85a97d-4656e0e69c2mr20343252f8f.23.1782136837710; 
 Mon, 22 Jun 2026 07:00:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466667882f7sm27155570f8f.21.2026.06.22.07.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 07:00:37 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 14:00:36 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
X-Gerrit-Change-Number: 1723
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1723?usp=email>
X-Gerrit-Commit: 516b6556e193aeb3a43c85599605d77fb38e68bb
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 14:00:36 +0000
In-Reply-To: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
References: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzZDUyYzZkMDA4NTAyMjkzYzNlYzU3YWQyMmQxYzYxM2RjZDFhOTRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <622ff2478ecf0fcf69f13c0cfb57ef6b001631b3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbfCf-0002hu-Jw
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 multi_check_dest_addr_allowed from multi_process_float
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
Content-Type: multipart/mixed; boundary="===============0118361639493620788=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0118361639493620788==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9CPRPzobibI="; charset=UTF-8

--9CPRPzobibI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1723?usp=3Demail )

Change subject: Extract multi_check_dest_addr=
_allowed from multi_process_float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(2 comments)

Patchset:=


PS1: 
Broken build


File src/openvpn/multi=2Ec:

http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1723/comment/99128d05_87a18c70?usp=3Demail :
PS1, Line 3=
130:     struct gc_arena gc =3D gc_new();
```
multi=2Ec:3130:21: error: red=
efinition of 'gc'
 3130 |     struct gc_arena gc =3D gc_new();
      |     =
                ^
multi=2Ec:3111:21: note: previous definition is here
 311=
1 |     struct gc_arena gc =3D gc_new();
      |                     ^
```
=



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3d52c6d008502293c3=
ec57ad22d1c613dcd1a94e
Gerrit-Change-Number: 1723
Gerrit-PatchSet: 1
Gerrit=
-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Comment-Date: Mon, 22 Jun 2026 14:00:36 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: Yes

--9CPRPzobibI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1723?usp=3Demail">View Change</a></p><p>2 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?tab=3Dcomments&am=
p;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Broken build</p></li></ul></li><li st=
yle=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1723/comment/99128d05_87a18c70?usp=3Demail">Patch Set #1=
, Line 3130:</a> <code style=3D"font-family:monospace,monospace">    struct=
 gc_arena gc =3D gc_new();</code></p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">```<br>multi=2Ec:3130:21=
: error: redefinition of &#39;gc&#39;<br> 3130 |     struct gc_arena gc =3D=
 gc_new();<br>      |                     ^<br>multi=2Ec:3111:21: note: pre=
vious definition is here<br> 3111 |     struct gc_arena gc =3D gc_new();<br=
>      |                     ^<br>```</pre></li></ul></li></ul><p>To view, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail=
">change 1723</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/172=
3?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1723 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Mon, 22 Jun 2026 14:00:36 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>

</body></html>
--9CPRPzobibI=--


--===============0118361639493620788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0118361639493620788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0118361639493620788==--

