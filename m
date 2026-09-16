Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C424C982C4
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:
	MIME-Version:Date:Message-ID:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9Js/2nh4XO0aj2zUuN4ZBWUVnVDPmmwtnJNmYcOwvrk=; b=A6w3jWH2WO7M85JitXfsc9Oq48
	MafWEF87UfwI+S0ensDHsowNEPWbdIEIN2VCAKBdxEn38pSBIhL2xFPW3ZO5iVr5+Ib+hjyPdYJ9C
	wX8UKIRo48ru7vXNM2HCnM4oCR0eDRUiqJboXY5yUlY5bWQxkpVNKJcnOamvArhvRG0c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6rMW-0002Eg-Rw;
	Wed, 16 Sep 2026 15:15:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <johan@openvpn.com>) id 1x6rMS-0002EX-VX
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 15:15:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Subject:From:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rnXZxzCOIBD6OazMJmwG+tnduRdMso6higXW4fmxW7k=; b=EFYoYkM389XJ70PrNtUxSJqlCa
 PV87mrbTaX+ZyaMq/TEcP/fsb2e0lUWobm6fV2E2nmpOHKY1PcO4Ln7TuqbHQcTZis+WP5sxJd8ZF
 pG8CLC8zSVKo/o8S1FjsKHFQg9OQx3GVeCYP4OFPhN+a4f8yVVMnjTAAMLhRu4L18Sfc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Subject:From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rnXZxzCOIBD6OazMJmwG+tnduRdMso6higXW4fmxW7k=; b=Z
 aM1pPkBmoFnjaQE601oP0NdmnE8Rym4R+JGplGWTdIa1y2rLOCv+09sCp49T2OknLEFCgjLRpENpz
 MK5+JyflFXPd5sTGqkitk+VHUFHhrgj5QpS7WUY1H0k9N5kMi+ZFkpCibqX1tYVz1pBXOzyc0x05V
 ri2b1JBLlMblhQ1k=;
Received: from mail-yx2-f13.google.com ([74.125.224.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6rMR-0007lp-Dh for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 15:15:47 +0000
Received: by mail-yx2-f13.google.com with SMTP id
 956f58d0204a3-66e4ab222dfso1124451d50.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 08:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1789571741; x=1790176541; darn=lists.sourceforge.net;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rnXZxzCOIBD6OazMJmwG+tnduRdMso6higXW4fmxW7k=;
 b=FOEQQmM5MOni0v3cGGp9PWW9F+k4w7GD2DF/HXd/4AtMSVM/QLGQmqL6OfajiDi50l
 Lf9clgyjdLn9AHpLlqAtgX1uVV9QbWyOWzmuYXpzJrgwyNyeD8S9nvBAViywkrZSC/4F
 Vlj3j8acq0l0p69zOjCbnQzfup18Wbm8ai2No8dLghM2uNKkaVFKO7pCOMpyPHsIBwDC
 459fW26LiWvc6JmiAWVQ7Id1CHCd2qFDaGIHrRdu5LC0QAfS2la67OaVvtowqhveUbrQ
 z+7Au2ucxLHLVGYmDJ9EkoHLe4dAEJORYBKVzILwyijn1EAXBHemQBGrGRGpPAoKGhxB
 ccMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789571741; x=1790176541;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rnXZxzCOIBD6OazMJmwG+tnduRdMso6higXW4fmxW7k=;
 b=aLOxjN8GuihWn/nvz8u/QQebknGgoYQ6WiV5LcdZCCJES7c0kszVDTueKGf8gbZc8W
 3kmi1DkVO/ipHDlAr7TctgA0y4fNzlkMe75sLO38oehJSSX7LRZ0HL0AvqqmhxjCzsRa
 jUNMliHJNxFznwt691FiUzA/fv7fCuboD8EKo8fWvMtazrwXV+v+I1hvpeJEe/GQWNg9
 BffBA+jzs00Pw63zN3mrsugqi0Bw6liFv0kgwTDi7TZyWeJnKlIRV6uof2s429uv3Edd
 7K38S66qRspioYxO5GT8mQ/7bt3vAfsoodNnXYroy3aPe9gbf4eap0M0F6O5meQywwgY
 VdPg==
X-Gm-Message-State: AFuF++kSuoxrR4h9AA5n22nxlN13iu2wMv+pTQG7mEMsIuNK93nSHLSc
 MKB/krPDshJJoUbh9vyK6/Xa4nvH5QBkyYKWMxUICrJMDOSkABeKFj+PAwG3hqJUiob45xrgYLI
 P0hH+HjVPgL2d7p2bxFfSxCmdbJsxXyXAQqrkYpM/uxYGwnm6PpQCLupdar+ts4mCU4FS/onA5H
 ozSh2p/ETO6aM=
X-Gm-Gg: AYBFou3RXEhFZ8xqmdKry5ns/RM/Rz/QRLfrhPXGUSqNrICM+dohmRIwtwnqSWJNEql
 /sYoIJ+WW4/+Oqz6jlysaOUhxEqccI96LZDBu4jISxUGE9or5UkcikUmoEkHgzAlzCjKrymga7z
 NdS4C7f0wxnX70kJ4zAZ1pRsVfJ2Mo5sOtv5KpgTQdFaW18IFOMT+vSyAnUHnXkpo2EqvIMkdBK
 ol6kxDXwDL+qKxXfHh3pAisvUc0bUY1/xikclBvVjBas+YtDgJZXMYfN7AT7UsYR41FGDLd1omW
 +s06+uWil8fynsCvZE2n4n6m8mHQIYD2NddcbDr/6eY2fciMDvczFffFiugSgshSomhVwsRm8o4
 o9RkNpB+prvZJGpH/nHYLn44HEYBO4Xp9AYhOXoz9C5W7K1c+xb8cGg3uvs//Li6iB27cZJmTrl
 GZJ9dn5O1GRnMi7udMnUw+J1suV3Pfj/3sqN/BDWXUMwM4CC7qd6v2VhQqRWotlTKREcTtTd3ZM
 uXU/fEbQH1TxXvVEEF2ZpNzyyTBTz9MtTvWNgDrVg==
X-Received: by 2002:a17:90b:4d:b0:39e:433:23b3 with SMTP id
 98e67ed59e1d1-39e1e489edemr6158694a91.14.1789561504241; 
 Wed, 16 Sep 2026 05:25:04 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4fc2:28e0:fa20:d19:cf9c:1c51?
 ([2001:ee0:4fc2:28e0:fa20:d19:cf9c:1c51])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bc37f58sm4931191a91.14.2026.09.16.05.25.02
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 05:25:03 -0700 (PDT)
Message-ID: <2fd9e739-ab5f-4206-bfd1-0ddf33f9d800@openvpn.com>
Date: Wed, 16 Sep 2026 19:24:35 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
X-Headers-End: 1x6rMR-0007lp-Dh
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
Content-Type: multipart/mixed; boundary="===============2864092802720836544=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============2864092802720836544==
Content-Type: multipart/alternative;
 boundary="------------Mn5hpBvCGnfMEix38zOS9gKD"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------Mn5hpBvCGnfMEix38zOS9gKD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 16 September 2026:

  *

    *Updated: 2.7.x release*
    A few more security fixes are coming in 2.7.8, and this is planned
    for October 1st.

  *

    *Updated: 2.6.x release*
    Some security fixes recently released in 2.7.7 didn't apply cleanly
    to 2.6.x.
    Backporting it to 2.6 is ongoing, and a release for that is expected
    next week.

  * *Updated: test latency and MTU in openvpn*
    A new feature is proposed for adding to master; ability to do
    latency and MTU tests in the OpenVPN protocol.
    This would allow for a client to for example select the best
    available server based on test results.
    This is currently under
    review:https://gerrit.openvpn.net/q/topic:%22oob-server-probe%22
    The design document is
    here:https://github.com/lstipakov/openvpn/blob/server-probe-design/design-server-probe.md

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------Mn5hpBvCGnfMEix38zOS9gKD
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 16 September 2026:</p>
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
          Some security fixes recently released in 2.7.7 didn't apply
          cleanly to 2.6.x.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Backporting it to 2.6 is ongoing, and a release for that is
          expected next week.</p>
      </li>
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
        This is currently under review:<span> </span><a
href="https://gerrit.openvpn.net/q/topic:%22oob-server-probe%22"
style="box-sizing: inherit; background-color: transparent; color: rgb(24, 144, 255); text-decoration: none; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"
          class="moz-txt-link-freetext">https://gerrit.openvpn.net/q/topic:%22oob-server-probe%22</a><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        The design document is here:<span> </span><a
href="https://github.com/lstipakov/openvpn/blob/server-probe-design/design-server-probe.md"
style="box-sizing: inherit; background-color: transparent; color: rgb(24, 144, 255); text-decoration: none; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"
          class="moz-txt-link-freetext">https://github.com/lstipakov/openvpn/blob/server-probe-design/design-server-probe.md</a></li>
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

--------------Mn5hpBvCGnfMEix38zOS9gKD--


--===============2864092802720836544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2864092802720836544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2864092802720836544==--

