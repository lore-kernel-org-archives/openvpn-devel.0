Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F08CD8CB9
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:
	MIME-Version:Date:Message-ID:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sJvIcG8qj/ZVFm4e3oCWJe+XrrtbBG+/USOpZwMX9ik=; b=I1OER6L8/qyirtJ22baKncIcoc
	4+fxjbtkRfLoHGwRBMI0zSeiVHnbOH3rw45VeTudM3edYcJJB6EX0VRx8d7XGTxALFcrd75F4s+t3
	PRpTge6IpRyk3CYVXpmHTFFBGgajuaUaxPECzJPUOYNwmpI03LmPspmFUQi7I6L1w1ds=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXITL-0000GO-H7;
	Wed, 10 Jun 2026 12:55:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <johan@openvpn.com>) id 1wXITK-0000GA-2k
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 12:55:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Subject:From:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/L4V0tLNzoovv4s9PKotrmpcWj5a+cdcSCygAMy35/c=; b=WCBFTvP/JUifwVoYVsj2TQ4mkd
 Z6qnyxsH/35nFAgq7dDVtjsuS/HD645TKQgdCGw/4AK8OtTQiRsmuRgsO4ofRVcyqCz+VzqKgNB9t
 7mS/FnH6ekX+Oq7x7Bz3WMhdU53wZ7CvypWgWic92ds1agagPJ6kbGqWD1EuMCkFBRaU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Subject:From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/L4V0tLNzoovv4s9PKotrmpcWj5a+cdcSCygAMy35/c=; b=U
 BzbgWtQCnpsf9L1p6ylQ+0PIIoXvBb9mqTHC1QRCvJfpo7zhT6nQVu94wK2OHp+GvrMWZy82nIjU1
 Aqd38lAVZtcejZKEcmHXb6y8NVucYJ82Wh8TUkEQvH5D5WUV88WVqpVlWmJS2J0cDKMP5r/fDM+w5
 BEQxOFMQr8oN5Mbk=;
Received: from mail-qt1-f172.google.com ([209.85.160.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXITJ-0000L2-Is for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 12:55:54 +0000
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-51776b4de37so52235251cf.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 10 Jun 2026 05:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1781096143; x=1781700943; darn=lists.sourceforge.net;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/L4V0tLNzoovv4s9PKotrmpcWj5a+cdcSCygAMy35/c=;
 b=exyUyZFFf3CQHZy3swRDRtp2qNhnoASBbFeRfKooeZSiKTQpsewpl7wMLoy4FcL3bX
 Y+OXIf4k6ExU5+OQAU9iRlZ0S6B2Ty299iIf6Fbcbi6+h6bu49/1wCMWNsy5FmQEIq1e
 R0NkcsPc+1Rueazeq8mlQDJnNrgKKyVSlxDmro3ftxDrRtZD1LSpHx4hhWC6YHlNF2yR
 HsU/vulgSjMN8cJRbVss8vwdnbQxr4CvxmUKh7Rk6/8oM1jZ6AAR67rXgv4irmNcW25k
 WWgqDfG3mGuWKN3vNJVoBVdkQBjTvuPP37kBkOs8GHCMzbkSL2wPUTNY+pxc7vDOA0St
 gvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781096143; x=1781700943;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/L4V0tLNzoovv4s9PKotrmpcWj5a+cdcSCygAMy35/c=;
 b=Opgtl+1Bx9SBJcJ1cm2WmXB4SVxeoEhjexzuEpBtq0NMp/ltgepxJf4C1JBWuowOtV
 ZE0ftuJkG4wVjDwYHTjrKB5lrWDIL4ZIhQ2UAF+R/UiGEx7aag40pwjAA5mNg0z/inO7
 7WI7uQe3zUwwRbukZc9GKnj3B8dB1aQNa9ISoEC9UCbMccc5M+3NVMkr2DKqvqMHjzwk
 +KWFg7w6vhVW7JP4NMcE2iASi0w63p5Sz/g76CNd0NLDbIiwPit9xW83StizkLiNqGsF
 +DHSgJ+JrfI8mKVz0VXLAM24n7ilPrV1qQMlFwFPDCIlTIn5mZ8OnjQcTBGX/Rqd0F5c
 owxw==
X-Gm-Message-State: AOJu0YxBj9QPCCZOFykl3zlxPM33BYV3E+VCauRXSePvhH9NOCKSDQ1X
 n4gJLrOEzY/7bkXDhbv9ZxIJRnaafCVEnosoqGXrfnK9B/HvQ9UUdw8GLpLgqPDUiVgwJUOMsz5
 sSqzZyCV3UBJpN3mqUTjRAwS01VWk/+JhZ66StteZqaCGyO+tIdqLi/vtHSbqv8P92pAK1KEKPG
 4KxsTBVY5I
X-Gm-Gg: Acq92OFjdaBbn+PSsZNe5Y7y6nuN/9U3rI1PqvstnnFalYOgzmYUo3WlUCN715dHZwk
 wxZHGQ69NuAbswIxyX1YFh92SEvrt5IrolwZII2ThVXKgzxdugvHjJohu+ZbjroDsY2mPsm2jzk
 ZLdJFfD6qqy0D/E2W6XpPvBxquxt+Ty+6A2Byl76idJyz3oUIq52lczBVD1rsp283Lf+Ox6tOkw
 izTUJ7g949q9vlWNg7FUoPJjEqasukaYrRsSgBaNMnV20x/NFc3aMXL/YyTzGk7cXMTgb/uW86T
 O/G7yFQ6e3vq74Ia0td/QRI/nRVngXFZgoSbwF0jtMkc2LbIzGW/sBAyhHFzmMkVYaW2Ol3nOG1
 YGfzamuFTv9XuqTR5XaBwnkr2da1L5VNeQAcTBkJr0SlTSD42/nv2/0e272u82mr1GCdhCesibH
 388zr4MKq2DS3gN4ZNgIoUs5JrgsaHsQkDWIxuDNDhRJP7yohfwV34bLmVeFP2sieVnA7t+bjl3
 K2Jz2w=
X-Received: by 2002:a17:90a:ec87:b0:373:c536:6fc2 with SMTP id
 98e67ed59e1d1-373c5367200mr13082029a91.22.1781095827464; 
 Wed, 10 Jun 2026 05:50:27 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f83:3c70:2783:405e:f63b:3832?
 ([2001:ee0:4f83:3c70:2783:405e:f63b:3832])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6c76f55asm22858199a91.7.2026.06.10.05.50.26
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 05:50:27 -0700 (PDT)
Message-ID: <e35e0562-98e6-45f8-a3e1-200092e784de@openvpn.com>
Date: Wed, 10 Jun 2026 19:50:23 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
X-Headers-End: 1wXITJ-0000L2-Is
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
Content-Type: multipart/mixed; boundary="===============6017559140226084945=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============6017559140226084945==
Content-Type: multipart/alternative;
 boundary="------------Eq7wXDEzWklESeYekWyF0830"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------Eq7wXDEzWklESeYekWyF0830
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 10 June 2026:

  *

    *Updated: openvpn releases*
    Currently we're handling a number of reported issues, some security
    related.
    An openvpn release 2.6.21 and 2.7.5 in about 2 weeks from now is our
    current estimated target release date.

  *

    *Updated: community meetup 2026*
    Coordination is currently taking place
    here:https://community.openvpn.net/Meetups/2026-Paderborn
    The date is around 17 and 18 October, location in Paderborn,
    Germany. ordex has volunteered to update and polish the page, fill
    in some further details.

  *

    *New: mailing list adjustment*
    On openvpn.net some tighter security on DMARC settings is being
    implemented.
    Sourceforge mailing lists tend to forward emails with the original
    from header of the sender - in case of @openvpn.net that won't work
    anymore.
    Sourceforge will now send from its own mailing address email address
    instead and keep the original sender address in reply-to header.

  *

    *New: ordex suggested to bring patchwork back*
    Currently djpig and ordex are looking into it. This would be just an
    additional tool, not replacing what we have.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------Eq7wXDEzWklESeYekWyF0830
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 10 June 2026:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            openvpn releases</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Currently we're handling a number of reported issues, some
          security related.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          An openvpn release 2.6.21 and 2.7.5 in about 2 weeks from now
          is our current estimated target release date.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            community meetup 2026</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Coordination is currently taking place here:<span> </span><a
            href="https://community.openvpn.net/Meetups/2026-Paderborn"
style="box-sizing: inherit; background-color: transparent; color: rgb(24, 144, 255); text-decoration: none; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"
            class="moz-txt-link-freetext">https://community.openvpn.net/Meetups/2026-Paderborn</a><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          The date is around 17 and 18 October, location in Paderborn,
          Germany. ordex has volunteered to update and polish the page,
          fill in some further details.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">New:
            mailing list adjustment</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          On openvpn.net some tighter security on DMARC settings is
          being implemented.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Sourceforge mailing lists tend to forward emails with the
          original from header of the sender - in case of @openvpn.net
          that won't work anymore.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Sourceforge will now send from its own mailing address email
          address instead and keep the original sender address in
          reply-to header.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">New:
            ordex suggested to bring patchwork back</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Currently djpig and ordex are looking into it. This would be
          just an additional tool, not replacing what we have.</p>
      </li>
    </ul>
    As always you're welcome to join at #openvpn-meeting on Libera IRC
    network every Wednesday at 14:00 Central European Time.
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------Eq7wXDEzWklESeYekWyF0830--


--===============6017559140226084945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6017559140226084945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6017559140226084945==--

