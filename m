Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF9CC5B56A
	for <openvpn-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:
	MIME-Version:Date:Message-ID:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mXSXNxZFurz2tlWaxB9ldC97WiRcgGwuU8NWXsz7YPs=; b=VLKJ8Opbk6el1eE3nDhwOtVlPh
	lVsbvNH0cYN6/1VL/65IK+HJL58G5ttgWG3+Gi+rCxOKLqn0vOevliTwqnuzOVAlEfiCW7OBzRzf+
	V3cS7H01dbjnXleQZ1uBqpkwYekfB2r0b2wk0FG53pejClmAJdK8muRTV3GDXll28avk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wu8FY-0004oF-NA;
	Wed, 12 Aug 2026 12:40:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <johan@openvpn.com>) id 1wu8FW-0004o3-QS
 for openvpn-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 12:40:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Subject:From:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l4hs1NsGSaJEcQahsQwiZcK43w17Dq8db11IU0wTa4o=; b=PbQDFeZsReoHEORxyQMKUKVwka
 hlJIOcfq88xoDFg5ki5eFFg8kYSaHAbzvLhpoV1tYOIiMuAFlPI3QcMQj/UBk40qw9RQ380HiymTD
 DKmG/VlqU4xG1Iw4WmMDjO8X5FYlWBAgcVO/eDGuT+B+N9yjw4MF8jEv+1qGkgJxGBPM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Subject:From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=l4hs1NsGSaJEcQahsQwiZcK43w17Dq8db11IU0wTa4o=; b=Z
 ODJ6ADEg6xqRsRt5SO+hJHDJgaKKVf72lf7W2k6EIXH5cFHwuArsIqi2M9fC23mE4THfii2RPatic
 xG/0CCDsFUMnDhMGuYbA8uWZ7/RiOl1/MDqL+0AU6X5XDEMoJChx3reFybDyS1cFQ4z0k7KbOr1Vx
 +n1MhR+VzHnsC8Eo=;
Received: from mail-pf1-f173.google.com ([209.85.210.173])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wu8Fa-0001Q0-6k for openvpn-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 12:40:03 +0000
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-8485ef63b68so1273675b3a.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 12 Aug 2026 05:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1786538397; x=1787143197; darn=lists.sourceforge.net;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=l4hs1NsGSaJEcQahsQwiZcK43w17Dq8db11IU0wTa4o=;
 b=UC9gWj+sx7NlhbSBws7vULyBoL/YZunwi9RFb1GDzeTRlsZFgiyveAjVUxLigpYWI6
 0j8rCUyJnzxjPSksfli1mWnMwNuW4DyG7N9YOvWg4HtW8VMdoJ7P6XAyLrdzH1Ceom2Y
 HGUknkhLEaKn+cBs4ZMtPlsF1AsqxiA/gkBE5PcoEMQpCOVo3A7vnoDJKqO9geUw6S/2
 kyQXn4CpKqcn76yH+tbfEHR9d39IA8vD4OW3JmiYqFrAB9TQsgNFfiR9skfF0VIRXt8o
 HET/fI+i7FOhToEKD9yap6X1UW3UcfvURunmk8X4x1CbjLKeqIBM3vIKIk/fp7lSGiPU
 qBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786538397; x=1787143197;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=l4hs1NsGSaJEcQahsQwiZcK43w17Dq8db11IU0wTa4o=;
 b=N8Na1fzUAeNnqjE29jBHrzS3fHw/omzNp4074pvisG1Kmc4H6FrUV1fO6wrK3GAd8Y
 YUagJjZCcf/67BcbXiXXW/bhafQ4iU0mcMf4bo74V8Vo/loYD7j9LwoLYqOcS8Cr+C6m
 7qoyJNhEmnmSXu/feCO5QADK12ryATVL/NT5tTGk5dYZ/AnFna700mQk2jFo8ugRUCo8
 j+/8d65bxaPv12JDC9i3JBGRtbhie1pSuR4ZDmaxpD6t/nlsRJeq9VMdM51VgIXRot6U
 1/RICnK4EpBNXEoetO39b09hRnMiq66uICfyi1oKf5he5qTKKpZPqz/w7CDegBe1ds/G
 zY9w==
X-Gm-Message-State: AOJu0YwWqusmZrbnWo6sgWcdc0F57qrfh08v/Dh9uiOE4OrMkG3Sedzn
 Gc6aEqiJTPvjllh9cauAehhb3fWWr32FicJWJqTIrWFTqaCFKOZwjYvGM3DIL0Vstj/o5SOTEwy
 63RXVpEuEipLCfOqCC6IWI/Hz50Slc4gb3idc+gAggIpXLjytQNHV+AF3lcYfrwKSucvbQH7MGb
 I3FnQnpwQB
X-Gm-Gg: AR+sD123bUfH1fTXxbxBKQd3AlImc1lk1HAZC2DGe41FqDIrH+x46jsULgFq91UZV7e
 2Nx0L4h6x2m+DPsSvkGvkFFwiBJc1wOeTRgH/YYc6kt8jlMWEXq+Zwnk3PDI84jXnTWx8Y9iNAK
 Cyo0+Z0XNWRvj883cqatJD0WtUqscDpErB+Lug8VJa3J87c2uEuDCBTYrtkPEnF1z1yVkpL5i3s
 DejDwttsxhb2ZX+YhIYzZGSnC8tTBokz2XJ56u7t/cDrLj3GejB1oo6BffuSO65pNfuLk9y7iVH
 EzlqsOmcYI6tZTyMrmjKSBl1sNbu5m+LLgQjCyuDw/6n5BMH3pMINSGtFJWmI9pBsG8IUln56/s
 qgBznKvihQ5/xib3OD+bytEX//uTloZi2TTprE6ZRp2DJUXb4Uz843rclZhfsv4XLhZHK2D1iGj
 YtiT1499aceoADyBQCUCkfUNta//M8zl5+o6CNo60SAeVnoaNGusNJ0bijDbhRN6Gc9LKI8j3yI
 KcWtD7jjP6yJv5FCyw1rhGsxW/6vw4RpQ==
X-Received: by 2002:a05:6a00:3d4f:b0:848:48c6:480c with SMTP id
 d2e1a72fcca58-84fb54a14c9mr4885106b3a.24.1786538396644; 
 Wed, 12 Aug 2026 05:39:56 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f83:3c70:6e33:fc04:43f5:d700?
 ([2001:ee0:4f83:3c70:6e33:fc04:43f5:d700])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fb1f2645bsm921448b3a.50.2026.08.12.05.39.54
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 05:39:55 -0700 (PDT)
Message-ID: <6ca58276-9358-446a-ba4d-f737fbea03b1@openvpn.com>
Date: Wed, 12 Aug 2026 19:39:52 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
X-Headers-End: 1wu8Fa-0001Q0-6k
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
Content-Type: multipart/mixed; boundary="===============8880604058923059609=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============8880604058923059609==
Content-Type: multipart/alternative;
 boundary="------------CtsAbUWDOuRXecT9OKerRBcd"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------CtsAbUWDOuRXecT9OKerRBcd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 12 August 2026:

  *

    *Updated: 2.7.6 and 2.6.22 release*
    Last week 2.7.6 and 2.6.22 were released with some security fixes.
    There are also some security fixes backported to 2.5 but that branch
    does not have official releases anymore (out of support).
    cron2 mentioned we might prepare for another release in about 3
    weeks as there are still further small fixes to come.

  *

    *Updated: Amount of open changes in the queue*
    This is also a discussion topic for the community meeting but we can
    look into addressing things here as well.
    see e.g.1776: Start a new document CODE_CHECKLIST
    <https://gerrit.openvpn.net/c/openvpn/+/1776>in Gerrit.
    lev__ said he would contribute some time to doing reviews.
    There are also other colleagues from OpenVPN Inc interested in
    participating in the community.
    But reviews alone don't help if the bottleneck is cron2 not having
    time dedicated to testing/merging.
    OpenVPN Inc. is willing to contribute by paying cron2 to do
    community work - details to be figured out.

  * *Updated: test latency and MTU in openvpn*
    A new feature is proposed for adding to master; ability to do
    latency and MTU tests in the OpenVPN protocol.
    Idea is to allow to do a 'best server selection' type of logic, in
    case there are multiple servers available to connect to.
    RFC PR is athttps://github.com/OpenVPN/openvpn-rfc/pull/30and an
    early initial implementation is available from lev.
    What's needed is a community member's review and ralf_lici did so
    and provided some comments.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------CtsAbUWDOuRXecT9OKerRBcd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 12 August 2026:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            2.7.6 and 2.6.22 release</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Last week 2.7.6 and 2.6.22 were released with some security
          fixes.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          There are also some security fixes backported to 2.5 but that
          branch does not have official releases anymore (out of
          support).<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          cron2 mentioned we might prepare for another release in about
          3 weeks as there are still further small fixes to come.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            Amount of open changes in the queue</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          This is also a discussion topic for the community meeting but
          we can look into addressing things here as well.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          see e.g.<span> </span><a
            href="https://gerrit.openvpn.net/c/openvpn/+/1776"
style="box-sizing: inherit; background-color: transparent; color: rgb(24, 144, 255); text-decoration: none; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">1776:
            Start a new document CODE_CHECKLIST</a><span> </span>in
          Gerrit.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          lev__ said he would contribute some time to doing reviews.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          There are also other colleagues from OpenVPN Inc interested in
          participating in the community.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          But reviews alone don't help if the bottleneck is cron2 not
          having time dedicated to testing/merging.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          OpenVPN Inc. is willing to contribute by paying cron2 to do
          community work - details to be figured out.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
          test latency and MTU in openvpn</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        A new feature is proposed for adding to master; ability to do
        latency and MTU tests in the OpenVPN protocol.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        Idea is to allow to do a 'best server selection' type of logic,
        in case there are multiple servers available to connect to.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        RFC PR is at<span> </span><a
          href="https://github.com/OpenVPN/openvpn-rfc/pull/30"
style="box-sizing: inherit; background-color: transparent; color: rgb(24, 144, 255); text-decoration: none; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"
          class="moz-txt-link-freetext">https://github.com/OpenVPN/openvpn-rfc/pull/30</a><span> </span>and
        an early initial implementation is available from lev.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        What's needed is a community member's review and ralf_lici did
        so and provided some comments.</li>
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

--------------CtsAbUWDOuRXecT9OKerRBcd--


--===============8880604058923059609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8880604058923059609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8880604058923059609==--

