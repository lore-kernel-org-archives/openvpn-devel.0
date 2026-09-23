Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13B2C982FA
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 12:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:
	MIME-Version:Date:Message-ID:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=C+Mu5s1hC3HAh5kz5AhbZ84I8k8qt8wG0p0AamhJv9E=; b=RI2xBx/RtYGePCVKSA2ThjE1wR
	JfYz/f2TZ64PkTgAweRAvUjcXFBPxs6Q+SWk//OZSqPzK0cyFCIs4zxibL/hHE34TvEGicOTS9PVZ
	2EOApI0W1DbDdvZjuzX+qoWinycYx6l3qYnjPAPD9eBOZKuuIpPLG/7OfDroL32ZZn7s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9MFa-0007Ij-Og;
	Wed, 23 Sep 2026 12:39:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <johan@openvpn.com>) id 1x9MFY-0007IZ-UR
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 12:38:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Subject:From:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mOz+u5Ry9ul0ARsMgBv8tVx9m+X7J71mh1lmswciBJ0=; b=CAPZ+7c87rJKsG/s+AJqrMV5cT
 lRiMWAMmGs0mQt/ZHaaG3ekxCohXL7nEUlwZxaqh9ckEZzFdWs88Dj5kHLLfDI0op22saJBZ3b6pn
 aHHC2C5k5G0PJ11uB+qvgCyXX+A85t4rdeUy13dTImv3/WQMMO1b1cYZDR9hos68QI7E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Subject:From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mOz+u5Ry9ul0ARsMgBv8tVx9m+X7J71mh1lmswciBJ0=; b=V
 TfOaW/KcyrcdWd5/UHGDzB+IqaQJieGXR/jIE6/KK8z68J1oakMABMfC+70EDN5D2h98UVbQe5YJz
 o1OCkAj2UsLbB+R21cYngJKPkPdvD6E+vW3wOc5tDyD9Ou5/mcFW9VAVjkWyn44GxdfPgqwGmiFoD
 H9UvLJeTTLiEFrek=;
Received: from mail-yx2-f12.google.com ([74.125.224.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9MFU-0007wl-Vg for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 12:38:58 +0000
Received: by mail-yx2-f12.google.com with SMTP id
 00721157ae682-85d43db0c17so13624887b3.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 05:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1790167131; x=1790771931; darn=lists.sourceforge.net;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mOz+u5Ry9ul0ARsMgBv8tVx9m+X7J71mh1lmswciBJ0=;
 b=F1UI3zj7GRFM6SWDvvb0M7/sjFjv/xa7UZjUnVIDVAKSpfCGI72F4gv/RVRvsWu+4F
 0Oc+yEXEy+ZOYzM4AF6YLSen60DeLtT+4YONfGlhq7nrbcxYomwdDmh2e1jhFERHhlQH
 rDUWEyPMP8+KGvWd8T1jPIad7YMMFQ7Jogl3Zqp2ivzU2CZFUYEIFyJvN4xqPQ0ipqMu
 E1JM5MTckRm20qje4Kr4FwY+l7f2MAzsqnLnBCRjQxNDo0oqhVp7Sw95OpYkUWlcOfZh
 txA7bOX/TbnVWcMkdETM6L6uzO3n+WWu9hauubdPzhPxH/Ska6FTMxBo37B8w3cRhGJB
 SFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790167131; x=1790771931;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mOz+u5Ry9ul0ARsMgBv8tVx9m+X7J71mh1lmswciBJ0=;
 b=nBS27jP7AfKSLWD9ACE7cbADDhdwkSPRt0gxuRz3pAYc/FHPM6NXSAW0/kCocNWRnp
 Mwjw1LwYeVzUStpzW2IjVl7vQ/LTHwT1ABg3bnlmZqtvtld8kE/D0yFyE65efaWzzEUr
 uVnwqASB0H6h7r2g6LOGuib3eioV8WhnaHHJ9DfDcrdWygXDDXLqEYGJ0/gblE+9SWN9
 ABIdz7diiiRUkUeyqkCG17rwRylHv8vRW5whmyXWkY4m5ng1z6XknN4smKGFJgPKecpS
 X8vQzdwIBazqIIo5szPukSjX/SBk4wuL+/6NMs36FO5xZhAknLgEFJeJAFCIcAeCF0Af
 /MYQ==
X-Gm-Message-State: AFuF++k3tByzChmJJ4cnc7liF9Y2AFezKR3EXHhRaOXP65axhqPbOX2h
 Qi5xHiXs5fp1nxmPa5W5TL+nHjzEMk85g4vbbvvgcy1zNfkk1ZhETOXinNTTv/vAMPGxiQnGnwG
 2OyQJijzf/mEuP5Hp1ARywPNysY2rCDe8LGVKruXu5i8UfczAhcOhXfiBPgYVqQ1GXBNBFWa7kL
 YHY5unI+rhTlE=
X-Gm-Gg: AYBFou3Dn+nmArIYqfaYKGMdlnAohrwoRzpwftUrdUqdYWzReyKKC5FROVaIYCCdn1v
 sPmSoPO9/l/4JdDRcMdayGO0yGS7Le8Sn4DCSE5z8bQlVNvjKramNjeYamUz3eRcGT9KK7b1fUU
 tL+OBv6VcQmMhQp86Zv0Gpjq1eJVQaXnq2RlzWkSw4ciAoKnnET7Pwuk5kQ5tfTXhf8q4S+/thb
 4bxOI7cO7mt06GAbM3tSvwERfDNQ4NDpz7B61RFisl2EhtxhxUCwZxW2DjZ9kqHyM6HhqDJ8URe
 SmmPVdUOn8UK4/jpgSKO0D2yVDoYaT7GWINumj64U/EbuFgyM6PisRLFu2H+t7zJFaKzAYrmHMI
 Cjpc1en04cNJ3OYuwLs9TiWIvRIA0ISdX51wdFZ3HjQ66YjrHD2Eb5i41gloMCVLXkg5URSozNz
 ++xLNYYC3xOhgkjjxJl34jUw3OMbBwIPTaGMVFeZKQ10YlljYxLmfHHBXwz/H9gXzEfmS0TbLGJ
 P+eVgd3l7+GmLww51737mkzGYi2ZWU2oawpalJRXG4=
X-Received: by 2002:a17:90b:5384:b0:3a0:7209:fffd with SMTP id
 98e67ed59e1d1-3a07e5ea86amr2160525a91.42.1790166727143; 
 Wed, 23 Sep 2026 05:32:07 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4fc2:28e0:4146:857a:c363:dbc9?
 ([2001:ee0:4fc2:28e0:4146:857a:c363:dbc9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a07dc74977sm5208413a91.17.2026.09.23.05.32.05
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 05:32:06 -0700 (PDT)
Message-ID: <554ea180-28d7-43e2-a111-270ce759c8c4@openvpn.com>
Date: Wed, 23 Sep 2026 19:32:03 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
X-Headers-End: 1x9MFU-0007wl-Vg
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
Content-Type: multipart/mixed; boundary="===============7226852534493444427=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============7226852534493444427==
Content-Type: multipart/alternative;
 boundary="------------PTSEs7dWQMREJPU6VUZhD0t3"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------PTSEs7dWQMREJPU6VUZhD0t3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 23 September 2026:

  *

    *Updated: 2.7.x release*
    A few more security fixes are coming in 2.7.8, and this is planned
    for October 1st.

  *

    *Updated: 2.6.x release*
    2.6.23 is going to be released today.
    It contains a number of small security fixes and bug fixes.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------PTSEs7dWQMREJPU6VUZhD0t3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 23 September 2026:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            2.7.x release</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          A few more security fixes are coming in 2.7.8, and this is
          planned for October 1st.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            2.6.x release</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          2.6.23 is going to be released today.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          It contains a number of small security fixes and bug fixes.</p>
      </li>
    </ul>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
    </ul>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
    </ul>
    As always you're welcome to join at #openvpn-meeting on Libera IRC
    network every Wednesday at 14:00 Central European Time.
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------PTSEs7dWQMREJPU6VUZhD0t3--


--===============7226852534493444427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7226852534493444427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7226852534493444427==--

