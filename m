Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A3CCD5BD5
	for <openvpn-devel@archiver.kernel.org>; Wed, 27 May 2026 14:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:From:MIME-Version:
	Date:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QTNrFKzdVtQVLSKQnT5Md9NHK8MBFlQi7SyutZkuEC8=; b=fI/sBgxPazkbJ9c9yRMsHahVPC
	RIlfhbyMv0Hepvmy7W6OJoW+PZ4VE/XfY/4ZZt9Mq2L+Jdqd1yzGyMjKlS8QAauLPr84Y0iClBbCD
	Qs9nsmFANwMedSBW/hby76zvu/Y/so+NaCBmoYiMlCP5zoMrW9zhcp6PSCo61FSEFay0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wSEqA-0003an-Vd;
	Wed, 27 May 2026 14:02:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <johan@openvpn.com>) id 1wSEpd-0003Yu-E6
 for openvpn-devel@lists.sourceforge.net;
 Wed, 27 May 2026 14:02:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Subject:From:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w+v41c39zyrSAv6mEdW61G96o9QW4RmnAD0+oaikvMI=; b=bble2IaNH8FvA1U+6FxXcExdiv
 m12HTIbGhc+lr0urwBiL7h9KzStPkkhb2p3gQC7xczweqmlWD3J1hdATmC/pOUY064WzcEhlBTxCN
 k16JAC1hTVI4m5/zLIQRXf7+V/2GFdXpooJbY6ZRhr+MrlQrkd3keZd2/ziwmOpcEesU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Subject:From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=w+v41c39zyrSAv6mEdW61G96o9QW4RmnAD0+oaikvMI=; b=F
 kp+3AVa1LHxXyFu83C1gqUBhVyO5g110HgpjcuqP8H6WnW7KMcF6WBQWMapCMtR+897e2rpCBWohF
 /rtEBqNjZ6QchcRgeYmRV4tZCCPmIML/DXOORbiC5ryWF21laq8FLXee+Ny2Tj/woCwjFuDGM0787
 5iLaPYJqB3ya+1Vo=;
Received: from mail-qt1-f171.google.com ([209.85.160.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wSEpZ-00037s-2f for openvpn-devel@lists.sourceforge.net;
 Wed, 27 May 2026 14:02:02 +0000
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-516e1525aa3so47847571cf.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 27 May 2026 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1779890507; x=1780495307; darn=lists.sourceforge.net;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=w+v41c39zyrSAv6mEdW61G96o9QW4RmnAD0+oaikvMI=;
 b=OoWTDrDMb/o0V1XLun+JssxK2LzHJM4JRXSCLCCPqQphyKCJkWQSBzVmU/LsGrNniY
 ffaoasjlQ2v9BHP/LqT/nQae8IkCrx64di7GJ1As4Q16bsaUvYChNxyoGd4TmhHrcEBp
 d8AS63htyHy19MlYJlOhrdlh2Fx9ylenqacuIEyRnJYJNJP6hDSyHEtGawp31r3xViDg
 vg90HF2RW+IRR1szF5t1tcztAHsY0xcuQyWKJucoo6ywAYtOHUg3v3NNAqzmvZLGSjfK
 zNuE8BjKymt7gkaHehag/OsrQNeg1vK6SGa8ioXneIQ55oCUp+u6nPaXHYgnfSZ86qQZ
 +qNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779890507; x=1780495307;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+v41c39zyrSAv6mEdW61G96o9QW4RmnAD0+oaikvMI=;
 b=mao4N24I/S3DJkpaa9uxQ79uHB+C053bBTsAF6Hkx5OmYYqZf9AyRvwTqshxmWvxaa
 p5xummtMkv1egCF9xZeVlfRJ68sKYeMQzgoOJb4qAWYKVRe+Frpvkq+mogLnljVjG7BN
 7hfPLX69c+glmNUQEzK4SXzDODM6h6L0JCUqvonVyBF5ngAKf+UW5kc3I9PRlVy67mfx
 K/qU7QUDCWZB9z5a8yxmrf0wrqGGY6uvQ8v0zH7Gl5Ew6+ISoImf2UnjpfeF2RpodFLb
 Gv011V86YEX0TDV6zOaUwyQiI3V3/ruuyisLWy977UvW2TTKaWqX2UT/+zIiYARSA9n4
 yvuQ==
X-Gm-Message-State: AOJu0YwWBkkvE2NHH1JG05uUFR4KwdVQZN00qe/V5PE3LdNou/zckJ6V
 r3hGR+2/vSlJzH6Srv/yEUoZw3pEemqPt0OquVJWSrcLC/0CN3BWsT9mBpnbFihiZpR2XRW2pLA
 36aZ1Do/RekmrnNNDcrug7RG3VM5YE10DkGBf3CaGSVRuue8nUUIb2DbSVmo+ChfC8CLp+eS/i6
 6PKhAd+ni3
X-Gm-Gg: Acq92OFePS04WlSBpkpBh1ZDhI4VtEfDHjG4Nyf5qP4d5kYdeutpASwripmfca21iLP
 xS1+ZIn3lMQ6S6Y1GW4wjIzPLjqr89ovTsHlTt/ozvDmMq3kw13QTMbG8ZpZrT9YRFYQ+mmqYeM
 35H2fk7Zak/2OnayAjzd0Q9LDzoe4Z4Yg6Su1g99EAN5ZBJT0LrWK5FxxAbd8F3v62bCN422Yzv
 0AhCCBa6/Tk0Bzn3BT2wrUMP32sDhtxDUam416JLsRf1yev5d60DmJrPvBum6FYXFP//RQwwcaQ
 UhpBt1OIDkKolvWCojly14t0qEN4RCW7K6MkaIZd3CUiMcd+5WynCmH4iRh4XhA9F/UdhFTiFvt
 +1kWMZSm8VrVx8aRMcsboSLsopDxrUODyXPyxikVNwQ8tJGJtlSAPdD7gxxgUBTise0l2ssS8zM
 9EJ3Bt5cQTR6kghlmShgaIGJ/Q1R9tpUS9EO4R4xHvgr4onm81R2karB7gLS2pPxJPOtKF
X-Received: by 2002:a17:902:ce8e:b0:2b2:4f43:b48c with SMTP id
 d9443c01a7336-2beb0381369mr259840685ad.14.1779886240347; 
 Wed, 27 May 2026 05:50:40 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f83:3c70:2beb:3a4b:7ab6:f0f2?
 ([2001:ee0:4f83:3c70:2beb:3a4b:7ab6:f0f2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56ca7fcsm152742605ad.27.2026.05.27.05.50.39
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 05:50:39 -0700 (PDT)
Message-ID: <8fca6b82-8631-415f-8aad-2a1d28f1638a@openvpn.com>
Date: Wed, 27 May 2026 19:50:37 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Draaisma <johan@openvpn.com>
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
X-Headers-End: 1wSEpZ-00037s-2f
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
Content-Type: multipart/mixed; boundary="===============4303133213325634427=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============4303133213325634427==
Content-Type: multipart/alternative;
 boundary="------------0dzjs7UNj14BTSk20KtSza0F"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0dzjs7UNj14BTSk20KtSza0F
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 27 May 2026:

  *

    *New: DCO testing*
    ralf implemented a test that can be run on demand that starts
    various distributions and compiles ovpn-backports on it, to discover
    issues.
    Discussed testing on red hat but currently using alma linux because
    it's easier for testing the concept.
    Would be good to evolve this as it addresses a problem encountered
    where OpenVPN Inc. customers running RHEL run into kernel updates
    breaking DCO.
    Would be good to signal and solve this early.

  *

    *Updated: openvpn releases*
    Currently we've received a couple of reports of possible security
    issues, so we are investigating and fixing.
    An openvpn 2.7.5 release after a couple of weeks seems likely.
    Possibly a 2.6.x as well.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------0dzjs7UNj14BTSk20KtSza0F
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 27 May 2026:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">New:
            DCO testing</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          ralf implemented a test that can be run on demand that starts
          various distributions and compiles ovpn-backports on it, to
          discover issues.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Discussed testing on red hat but currently using alma linux
          because it's easier for testing the concept.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Would be good to evolve this as it addresses a problem
          encountered where OpenVPN Inc. customers running RHEL run into
          kernel updates breaking DCO.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Would be good to signal and solve this early.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            openvpn releases</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Currently we've received a couple of reports of possible
          security issues, so we are investigating and fixing.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          An openvpn 2.7.5 release after a couple of weeks seems likely.
          Possibly a 2.6.x as well.</p>
      </li>
    </ul>
    As always you're welcome to join at #openvpn-meeting on Libera IRC
    network every Wednesday at 14:00 Central European Time.
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------0dzjs7UNj14BTSk20KtSza0F--


--===============4303133213325634427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4303133213325634427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4303133213325634427==--

