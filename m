Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9445FC5DF97
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:
	MIME-Version:Date:Message-ID:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=915gXJXloCfu5I8JXvIy6OCy51TzUY10dcoFAUnKl9E=; b=fUjIQRNNzFrwzPis+JyWMcEybS
	RMT/LvqDQsTjsrTLDiEao2G8aBpHgs6cL0cc9OCB5sAZg7THf4DD/JxdhZ5KgNsNr5ymiZhj6gZDI
	FniFZFG8TZ7COLPsllwut+SX0hN+a5amQYfPS6ppxdA51WpStuhuOhyykvLeKbFJQhtg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzGDK-00036c-G3;
	Wed, 26 Aug 2026 16:10:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <johan@openvpn.com>) id 1wzGDI-00036W-Nw
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:10:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Subject:From:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mtF+AjD/WqTQq/Xc2sdOJqLDg8g5sGindrH8e0ZdUCs=; b=ZU6hzLVBTEHc0iA9Q9+b7AQ5MK
 P1+lJGGJatYpx4Wzo+ep7x08nJdP1CfSGkj/Jdh2hESNEQysPegh7clUAlJWTcbHpcNVKPJmrbuet
 FSx3FdUXco1nblKUxX4YO4VmNA14bpwPkCz/KkXCdvSRflb2Gial7R9ntFfaZH7k8NwI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Subject:From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mtF+AjD/WqTQq/Xc2sdOJqLDg8g5sGindrH8e0ZdUCs=; b=h
 xn6XEEv2TlAzS637hQv7Jbgett7ZXlEPh1cZdnPLtRdxoE/w3Y95lvtF+1HU8gF/dC9iecJ9uHi1q
 2FyRZP9ypfXbhs/pUSDv76m2uKv0aj8Qw8WLxDmgVf85+POejmlpMktC1NXtxfCplT/6dt372/zC8
 km+sm+Lu8mtUWsJE=;
Received: from mail-ot1-f45.google.com ([209.85.210.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzGDC-00016C-Lj for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:10:54 +0000
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7ee125ec926so984470a34.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 09:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1787760645; x=1788365445; darn=lists.sourceforge.net;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mtF+AjD/WqTQq/Xc2sdOJqLDg8g5sGindrH8e0ZdUCs=;
 b=ngz3ZfFzLxxPw9GdGierFUW0qyH62QMDVS3YyiUCjqPNSmlY/5xDhw1YyCkLiPsNPV
 NYK4gXtkKc6QrBUgJtwL+cHpQmY4hNyeF7QbNvXI3UhNJ3e7kGmBEKkcNwbVQGy4oF0e
 IodCcdZhZG1MtScpqsd8I9dg0XP7BoOi93a5ptnTXqzTsze73+F0pfh2EQCTPqG54RBH
 6VxaslSeYVBpUJNtqjylV19djAco68Ci4VFmWi/QKvAQZ2QFKHv8dUBl5Ca5wLvHWGkw
 fFBndFv3tPkzdSPWp7ekzW1seWjI5rTRbjjRAMrnFqhKcqCCymCiwmkD1MjYnexJ4bcr
 D2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787760645; x=1788365445;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mtF+AjD/WqTQq/Xc2sdOJqLDg8g5sGindrH8e0ZdUCs=;
 b=iav2v24hgat3EE4/bSefJ9tzG3vR8f4KxH4LSGwCrmifHGrpV7BP/cmjX8Byk+vKu/
 4yAJra4FzHGDJPXP488yFENu3tOAH9bymQgb7HT2B4zCbf+EkYJWipQYBopsd2c69JWi
 NPkiMp4lywnJh0Je41HR1F68xyCvChAVp8tg3tnXZU2QZeRzkz0KGx35cwTBvmPlhMsw
 d2UYa/yctLna7KRvRnNiKfMRdZ+sJqk53bCJMRfhT067Oleo3KX7tdaeQGIdjvEAht+C
 7Zm371FJ8D8NGAi73yLtm+3tUDRayeJz6zkx6kivjXW1pV8kXWfGbLsSCjUjl9PnOa6n
 4bOw==
X-Gm-Message-State: AFuF++kffmR3Hz4NSeqljN3Kn5ZQGkOCJYSkR6Dlfb7E0Tx5e9MNOTPp
 WIq6giOzoyffl5M+t+S+bpu6+Xs0B7VlnUc6I46EfwKH0BZDFkwL2YOjm1W/PmZrKKe+A0XF5+p
 GsWQLY0M8+Z0SwzI8cpLaLQ3r0LQdpcrfKsZF2eksBKUv3BZxD3GiNrcpf5LKAg4l4JCSWXi6pd
 wLtQ0UjNkJ
X-Gm-Gg: AR+sD11kCXSptbJ9Q8nayQkZjv+e5jMqhr+zpguf28mMJunUKZpI6Nio8KrIV3fQcmB
 7cPaUrt9SEaIl7FtDiythMZL1Txih/WsZG1kbOClKWFe2lPU4jV9eAM0tS/oNM9+tvgesCV4IOj
 oWRqhntJHKxnEI1p3C57vPEUZYJ519bbkmE707uqX3aEC1UjQF+3wwp9T/an5kA662SSiTet8QE
 LhTNwGIJzcQcvfsofF0MzSO2wpDNvF04YayyGFg69Ofb7NuZXktpROgTTALR48++/Ed7L74JJIn
 XePcIaPxRudZlDehJEfMxbcFF3ipu+Uk84EAU7O7ZVmJKMAP+nAbGomjUInD5br/P/tzZT8DKNU
 CJaXKQYc8exJqrC99VH+aeQIuZplB+lrFpj6PxfNbkNYkusazglGjHlwNvRKPU4zvGDCRn00JY0
 0nY+mnkKgmrcDFlzUoK1g25rwEthgu43fiQ9j4tX2lhxwcCaMlQk0z2RPvjFQ3cBJcY5yBoRGwJ
 D93HcgTJkfh6rm9DK2uLrdfIEYG0uhKmw==
X-Received: by 2002:a05:6a00:3926:b0:84f:dd30:1890 with SMTP id
 d2e1a72fcca58-853755c3b20mr12054127b3a.15.1787754654674; 
 Wed, 26 Aug 2026 07:30:54 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f83:3c70:5180:1bb4:196c:c77d?
 ([2001:ee0:4f83:3c70:5180:1bb4:196c:c77d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf2472fsm1015373b3a.48.2026.08.26.07.30.52
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 07:30:53 -0700 (PDT)
Message-ID: <9c782759-145b-4844-8816-e2218371965e@openvpn.com>
Date: Wed, 26 Aug 2026 21:30:48 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
X-Headers-End: 1wzGDC-00016C-Lj
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
Content-Type: multipart/mixed; boundary="===============8249059945932902645=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============8249059945932902645==
Content-Type: multipart/alternative;
 boundary="------------7nArmZ2E5RSfbVyLbH4ZQekh"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------7nArmZ2E5RSfbVyLbH4ZQekh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 26 August 2026:

  * *Updated: 2.7.7 release*
    Currently we are aiming for another release at around September 2.
    There will be some security fixes addressed here, most under
    unlikely scenarios.
    There is one CVE we are tracking that will be in either this release
    or the next.
    Currently we are on a 4 week release cycle due to pressure of
    ongoing reports.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------7nArmZ2E5RSfbVyLbH4ZQekh
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 26 August 2026:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
          2.7.7 release</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        Currently we are aiming for another release at around September
        2.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        There will be some security fixes addressed here, most under
        unlikely scenarios.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        There is one CVE we are tracking that will be in either this
        release or the next.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        Currently we are on a 4 week release cycle due to pressure of
        ongoing reports.</li>
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

--------------7nArmZ2E5RSfbVyLbH4ZQekh--


--===============8249059945932902645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8249059945932902645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8249059945932902645==--

