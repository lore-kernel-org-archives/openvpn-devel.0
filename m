Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493A9C61DD6
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:
	MIME-Version:Date:Message-ID:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=adCNMN+o1nyn9g7TRwtan2HMEkKL3BT1QATGkjT8NxQ=; b=A9djjtAARLyOjMtspEkhmb9A5N
	jFbGX/iVnffarsduPIvr0HaoFcoXhRYwR6VUnlmbS0vFoSa9DN6GZ+MVUZaXYguuwB3xxAstHnC82
	3AYPkWRsw2dfI72e8I0AjNqwz7zYSVP7e8s2fOiKc1NBQ/Vx7vF+8HzeRY7xchWmR/qI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1km6-0005WS-Oz;
	Wed, 02 Sep 2026 13:13:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <johan@openvpn.com>) id 1x1klr-0005Vm-6z
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 13:12:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Subject:From:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V3rY48Z7dVJpIChEMB7mwuEWKvjJkkq73lCS4e7nReQ=; b=SB1QueVldB1I9l8/PIvOoLyea6
 tY20N6oatHQnOz+6SeG81oxwK3tzRIlE5zr75HsTMzBX2KwNDeqSRutHiTlBsTLrb45WDrDrZZXr+
 cYCW5z1hwGHI+wqD08vJDPM2rlnT8A91SRClopfDQj+H/pFheTEIYh/R4CtUBWnVwwg8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Subject:From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=V3rY48Z7dVJpIChEMB7mwuEWKvjJkkq73lCS4e7nReQ=; b=S
 5cFZaSYuEW7vYsn9H7LR/ptMJB4yytgHH7/xOFXOHrSvy+mVuf8+r/kghtMOjObKZaqz5wmNNE6PG
 zSB7MTZQN4GgcJh0FsiTESsiCTbMORWrfVJM+8pBNWexlp29sLIC3nASyl/Wof6VV3xerAqwqdTgw
 hzCS75TDPJ/OV7NY=;
Received: from mail-yx1-f45.google.com ([74.125.224.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1klq-0001ns-Jl for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 13:12:55 +0000
Received: by mail-yx1-f45.google.com with SMTP id
 956f58d0204a3-66e63afda8fso1004873d50.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1788354769; x=1788959569; darn=lists.sourceforge.net;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=V3rY48Z7dVJpIChEMB7mwuEWKvjJkkq73lCS4e7nReQ=;
 b=JKNMAZeNf3jOI61/MN2jkJT51HdXtuoG0X9K6esroaEkvTsjPFnM2oMTR2tTySlQv7
 9LQ3m6ZS3J6FntMnFpQWl7x087EaXbQcgOGXLve9OyzHTSBk5NLgPGjSqTwSZ4GLFNNL
 xxmK+JZdN43ygB7+YqcIya9qsVBYC2tX/WMJm2bgoDdp4c4yofSgzq68h3al3EIocfLn
 J4I51LyKVgL734au7O85Xub8kkzUe+jrNomDw4oa6rrCjjeICRWi5ATGnEhBsBt/A7HC
 7f7DgbmULJVwDAfW/3aaZlcRAvMvFqoLOMIn6vFAizmTUvcWghEuR3+AZZQXVm4Tb/Nu
 JyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788354769; x=1788959569;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=V3rY48Z7dVJpIChEMB7mwuEWKvjJkkq73lCS4e7nReQ=;
 b=Z6dWDtPec3A8FS7tFcAnfwu7wUUnVh23VV1ivyOSFjB5pTbj8IlNXqspPQ+P7SHQhE
 NxwQVPW84lm/KaxTJddHkDzNC8Cg9oCrSmgx3FaCg572E/Wxe26J4Q0H2XIXcuEOhmA6
 ycb/t3owu1+g/v3A98spBFfZgBAKqkhCz+BgxQbWJmMUefVhu7yxfE1pZSysTdyV+z6L
 vIqDyOYvtCKE6c4bS735u3L0cHPP2dJJVesnD4kygV5xtHJP9f9IxgJ7Ig5Z4dx0FnVC
 2nsGKioZL69sAMd5/38rtyqrW4K7SVy4urGpxktBkhgRQkRPJakWiPTn6Uq5zm9vhBRc
 aStA==
X-Gm-Message-State: AFuF++n+3gMsxLhB2RdWKtZicNvVM6weXCK2Kh8vOm1GvaBdhKCwqeo0
 BdCF5ZYL6SfXmZ1veNNmXTV2mnnEej9wsbvjaUh2DXXiuHpdbaj4ZzGFRQi3RbbfSGSuhQ+TGy5
 ueiQSXYN7fT2zwnlNxSor8oNz73qFgxRF4cHqbLuTBY/RZU5Rcr8hzDoh922NoiZS5zQB9IVObl
 EI2FUVvA==
X-Gm-Gg: AYBFou0T0sD8gFqFWqQaLKekn43zKfKaS1FTWVBFddSjdQtO5GAFRsyXwz67SQzTm+0
 jysKK3TzvwF/juG8xLZS/7Dj7Hw3Fg8RbfKrk46bi5e4V0Dl67NLqKIRDBgNaOh38fDrTGE1VOD
 WKkDEIlR4elMWCYHQE+oHuhsXvmURpG+d+9D6SXMmx5ewIjg5hQ1NXzY+voYqoF/BLGh2WyygVt
 GVu+N66SzCVS+FaLswSr7HXxch0IVt/C59F+ytNo2lj+XNKelTAN/kMoow4Tpesi821CtwjPgtf
 iSjLvCeWJ4o323wv8pkLtwEeZF/cRBrkAUkZog+OL77asn6/muFNfu4x8nzBgMchiK1lp5G2xqS
 izQDV9FQZK1kWp4yH7yGW6w0O5fEnWKucnGc2cHERO+kuL3MPIwjp6FteZcpOH8xtnqsjgj6ZgW
 WJH2w51dB3CFhMXvfwOu2gU2IKwUahuo1ShChTEXbeX2OEkFSo2CEd7wDyne0BFnaAXNz0Se3qU
 tOWNKj4taclQklLQYTl1X2ulAnLROidVns=
X-Received: by 2002:a17:903:324c:b0:2d9:123c:8c49 with SMTP id
 d9443c01a7336-2daec6d8a15mr74191115ad.14.1788353152446; 
 Wed, 02 Sep 2026 05:45:52 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4fc0:e8f0:5cad:f76c:37e4:5e01?
 ([2001:ee0:4fc0:e8f0:5cad:f76c:37e4:5e01])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dadd39e9cfsm12411425ad.34.2026.09.02.05.45.51
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 05:45:52 -0700 (PDT)
Message-ID: <eadf5cba-3ca4-4b6f-91b7-26195cd0a887@openvpn.com>
Date: Wed, 2 Sep 2026 19:45:49 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
X-Headers-End: 1x1klq-0001ns-Jl
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
Content-Type: multipart/mixed; boundary="===============7707450175326663744=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============7707450175326663744==
Content-Type: multipart/alternative;
 boundary="------------NuuWy74eG6qLqRgZM7Mpwmvs"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------NuuWy74eG6qLqRgZM7Mpwmvs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 2 September 2026:

  * *Updated: 2.7.7 release*
    We are preparing a release this week, version 2.7.7.
    It will contain some security fixes, one of them of a DoS type, the
    rest more minor stuff.
    Currently we are finishing up the DoS type security fix, as we
    consider it important to have that one released. We hope to get this
    in.
    Expected release date will be 3rd of September.
  * *Updated: test latency and MTU in openvpn*
    A new feature is proposed for adding to master; ability to do
    latency and MTU tests in the OpenVPN protocol.
    This would allow for a client to for example select the best
    available server based on test results.
    The RFC for this was merged to OpenVPN protocol specification
    documentation.
    The patch series can be found
    here:https://gerrit.openvpn.net/q/topic:%22oob-server-probe%22
    ralf_lici reviewed the RFC earlier, and said he would be willing to
    take a look at the patch series next.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------NuuWy74eG6qLqRgZM7Mpwmvs
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 2 September 2026:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
          2.7.7 release</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        We are preparing a release this week, version 2.7.7.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        It will contain some security fixes, one of them of a DoS type,
        the rest more minor stuff.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        Currently we are finishing up the DoS type security fix, as we
        consider it important to have that one released. We hope to get
        this in.  <br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        Expected release date will be 3rd of September.</li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
          test latency and MTU in openvpn</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        A new feature is proposed for adding to master; ability to do
        latency and MTU tests in the OpenVPN protocol.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        This would allow for a client to for example select the best
        available server based on test results.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        The RFC for this was merged to OpenVPN protocol specification
        documentation.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        The patch series can be found here:<span> </span><a
href="https://gerrit.openvpn.net/q/topic:%22oob-server-probe%22"
style="box-sizing: inherit; background-color: transparent; color: rgb(24, 144, 255); text-decoration: none; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"
          class="moz-txt-link-freetext">https://gerrit.openvpn.net/q/topic:%22oob-server-probe%22</a><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        ralf_lici reviewed the RFC earlier, and said he would be willing
        to take a look at the patch series next.</li>
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

--------------NuuWy74eG6qLqRgZM7Mpwmvs--


--===============7707450175326663744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7707450175326663744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7707450175326663744==--

