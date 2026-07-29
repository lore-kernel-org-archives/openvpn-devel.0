Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A04C54F51
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:
	MIME-Version:Date:Message-ID:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9H8DBV4pMYX+nTWPQFWP3eTQoPcE2t61HRVv5ucMuuY=; b=DFHQcV2rZqScwccra5Sl/t6EpF
	5vXm3/5PHDh/luKSKegi1OjHWk4ykLxbwO7zwe87bXPSt73SgajyW2DsQWSd1FVtTYOw8YNKhr/jx
	00QhOCThQgk2+E+T8fW8XnuaErSrDy+IeYXOf9rcNyKLh0Ervc/vvBRSKb6UUYS/bx9Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp4Vn-0003xv-0o;
	Wed, 29 Jul 2026 13:39:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <johan@openvpn.com>) id 1wp4Vl-0003xo-RO
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 13:39:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Subject:From:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UahAehuqdFYUT8hfGiF0E397BepFz4ZF1pru//0MXfI=; b=D1Dj6EARq/FMLLGncxUOmgu/hQ
 U7+7cWxXA4inzexMUmj+Mgo0FfjxOKyfdYwlxW1lxP9rr7Y31YodhYFqkOkwWqsg/3e3mRMwVJfUY
 lD4v0yg9lBdjUJ3yKQSUn+6Nixda13qED4QTfdEi9BCnp2fwUGbDqLK0yE5lKolF3Qtc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Subject:From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UahAehuqdFYUT8hfGiF0E397BepFz4ZF1pru//0MXfI=; b=Z
 xU+V1vwYP3OHjgOuw6JIoZaKMf08u7E/6i3Yrv0PVApjVPb0jDR+sRe0En4Sslodz6ZMLANSPRZQC
 qXZ977GrKTz3E6ATTOdkS3GgSze3+coRoZoOI3IUv8cyvO7TpHiEMyq+x5T9sGfUipuEw1FK935RH
 kDW60bU4y4mUHNe4=;
Received: from mail-pf1-f169.google.com ([209.85.210.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp4Vl-000840-4r for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 13:39:54 +0000
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-8485b358552so1081700b3a.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1785332387; x=1785937187; darn=lists.sourceforge.net;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UahAehuqdFYUT8hfGiF0E397BepFz4ZF1pru//0MXfI=;
 b=zViuVaOND1+ucUa64jYbDrJJwMEe0OrvRAOhQ6pKyqv0JRPr24dMaM1RZVyf9740wS
 6KSAp1lBAwGCCuCf39aUOELa3tseG/Gbq7zbgNOlSdUf7MUyUF94JlDjb52NuKj35N3O
 yx2dQorZ05qfnA9Co2pU8qAQCGm9/It5L3W6VSFLXRwLEv8NK5n/nJyb2Y6qeNJhpZBW
 WPBIn1SBXr6s0yyJgu4+YjQ6gzxSlwH+N5WSz9F1PDOvjr4iy9XG5UCYJud1WQesA7Pd
 1H87xYqY2Whu2XFvjEQjQLc+Y4dUnYdwzzsy8OQvOdGZDmPi8M2/47d5kGdCCBJZjrWs
 wlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785332387; x=1785937187;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UahAehuqdFYUT8hfGiF0E397BepFz4ZF1pru//0MXfI=;
 b=UWFSSeFx20+Yy9f+TXfYaOXkbjc9ckHAZd0cxRzFLtBNynJLAKVjun+4Ssx/M4jEX8
 vOYVvjNon0bPf6bG01WeDEfjsxc7cIFQpqHeKh1r/9DfAIQiLQfzf+tTIicJw9ifVx20
 JVzZVdwNFhiM7WC2MHjCTDinUYSIhHQBTewOx23550HLiR8Zo4JIYfYzSkFb3U2nffgD
 x5+Koi2pV0iw/b6Yyn8qM6HJyq6sxK7B5sHC7L047oyupzGSBUSe//bY3uiQhKoX/CdP
 odKRK/7PCbYbcVoB03mZlXHQ7oNldiinZ+XCyQztv+MguAlZZLPmtMiiP16xy0h/bRrB
 uBAw==
X-Gm-Message-State: AOJu0YzusXkyksLiOi3HEDrmz9LSPX8OoYb3gF8i9VTLV8b33NQJALoJ
 1DQt82QP1V2BmEbSVmm49Xfc1sJIp7VQUKKPe+tFq4DW83Cp2up4hdtJPEQy9GMfGv2A9BI1LfS
 yOdMpetxLM6snYUFn8h7Ccp1pj5aCX8rLsQilaWvsBZ+C8jwQHXbiCfvT98Rl3soszxDc7DtAWq
 cI5/leuQ==
X-Gm-Gg: AR+sD13NIQM2JFzdcaTtHfT+VpLhnBrNBGDt+AKrw26xyRYbPslpi8R5sI1/i64PyGR
 MiEBxn0R8pbUKzMfMn+vgn6nYLKtGy/qnqkSvH9hzlG5MX03p904ktUsgdkbaCAPujckyXgDkMu
 menWt54ORp+0a2WylKoB9wCIZLBUizAGeWPBs3EcuvhIGTw7e6+U1+B+nIQ6+ZpAs1dXRfTPkEH
 0wgmLMbQCbwIQrx+5UveaMQ44h5n3/VcHb14IByUqybSL1uUDWt4nEuitEXK4h9PNu07QMffrid
 hxlVXQsKUK45WsVdlUWx49PeoKbsadlr/HWHUou1oob0hG4IVMNn6tet9Ef2YwP2K+wxK3VanY7
 H8lptxAClpaBAETNfjWb/mN6dh86bZ3quCe0ji1AODiwYhKt2pnzA6rEQJh87pk9CSQuIyuFpq+
 VVW1QeG4Tii6OLyvPDkABUdKlnOhgkSj0DYhk3j95jOGcr/lSVm61gNQ5vUMXv2LZepMb+x4C1A
 zzPG6lzhI9uuiHnni9FLBy1tOBRqLeW1w==
X-Received: by 2002:a17:902:cec2:b0:2c9:ff29:3f73 with SMTP id
 d9443c01a7336-2d015d11a2dmr76315095ad.28.1785330871013; 
 Wed, 29 Jul 2026 06:14:31 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f83:3c70:6c0e:93d1:8f6f:a6ce?
 ([2001:ee0:4f83:3c70:6c0e:93d1:8f6f:a6ce])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bf39cdsm11091035ad.55.2026.07.29.06.14.29
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 06:14:30 -0700 (PDT)
Message-ID: <c8d0a9ca-758a-48c0-8645-e051efc17f1d@openvpn.com>
Date: Wed, 29 Jul 2026 20:14:27 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
X-Headers-End: 1wp4Vl-000840-4r
Subject: [Openvpn-devel]  IRC community meeting summary
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
From: Johan Draaisma via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Johan Draaisma <johan@openvpn.com>
Content-Type: multipart/mixed; boundary="===============3456380130443702297=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============3456380130443702297==
Content-Type: multipart/alternative;
 boundary="------------ojnDwSCo64JHwcwFQ089gErW"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------ojnDwSCo64JHwcwFQ089gErW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 29 July 2026:

  * *Updated: 2.7.6 release*
    We want to do another release for security fixes. Some of them
    didn't seem worth keeping embargo on, so those are reviewed on Gerrit.
    Currently we are planning for a release next week around August 5th.
    There will be a 2.6.22 release as well.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------ojnDwSCo64JHwcwFQ089gErW
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 29 July 2026:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
          2.7.6 release</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        We want to do another release for security fixes. Some of them
        didn't seem worth keeping embargo on, so those are reviewed on
        Gerrit.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        Currently we are planning for a release next week around August
        5th.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        There will be a 2.6.22 release as well.</li>
    </ul>
    As always you're welcome to join at #openvpn-meeting on Libera IRC
    network every Wednesday at 14:00 Central European Time.
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------ojnDwSCo64JHwcwFQ089gErW--


--===============3456380130443702297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3456380130443702297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3456380130443702297==--

