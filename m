Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D530606A328
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AMl2g4eL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=a07zIdGH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LMZG3kR+;
	dkim=neutral header.d=openvpn.com header.i=@openvpn.com header.a=rsa-sha256 header.s=google header.b=yDmpq1CC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:
	MIME-Version:Date:Message-ID:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=kO/IuV3M/RBW9bypluHfLJBDZoSwTK9T41uRoLwfUO0=; b=AMl2g4eLyr3yPDmJJZm2nNb1HF
	UIkuayMCWjFQDs4IHIZaCfGfz9yvfAYi0Ib+8DdFRIdOGf2AyKOTF11wXPTkj4KfQ7kNGdsmvgvku
	Zl9quGbodP2nON62KN0nsfh1yVt4bl6x50OpIu9D4dojhvqCArGTdcnWxnkIeiND//so=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOc7F-0000000044h-1674;
	Wed, 04 Nov 2026 14:37:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <johan@openvpn.com>) id 1xOc7D-0000000044b-35zY
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 14:37:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Subject:From:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nC3nKpYt3tZdvI67lBrJocJ9PQSRSlMVg1vYJbFrszM=; b=a07zIdGHSefAoVoi0MAKd5qPIU
 k4C/s7PZiStzCANtEJjMtJNV2fWtT3VxvDS+KmgZq6HN+gmlNXrOaus07CQN0kgZEGSC9mKWcj57D
 OOy/q3OcdLyEIbvOQ4WTsJQFgPhiybjthq3yiEfa0d5S32yWFTq23iXJ7owxeyFVELEk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Subject:From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nC3nKpYt3tZdvI67lBrJocJ9PQSRSlMVg1vYJbFrszM=; b=LMZG3kR+GKLO4gKCBZlEuViBVr
 9NnWnx+1xvSrZP+SXev+jD6/PRsnqcLdF8G7esoX3PyDvaFqGStMtDoSbuBWNq3jbTjfrjg+oqpYC
 vImDUfbpYhVq6S14vKHJJDbimhKifmKwgdU05OwwLMwLsAeaUjMuRHjFBhjvMvmVvS8Y=;
Received: from mail-qv1-f47.google.com ([209.85.219.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOc7B-000000003K3-3fWl for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 14:37:27 +0000
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-91c76540d0bso8755006d6.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 06:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1793803040; x=1794407840; darn=lists.sourceforge.net;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nC3nKpYt3tZdvI67lBrJocJ9PQSRSlMVg1vYJbFrszM=;
 b=yDmpq1CCGe6JSKS1M4bKoW7BxSbf6qpwWjxsejb5N504srhK59S8GTgxyztP1wkkuQ
 YDp56Aa/p9mkgFmtYKtYeoayJZKR0rb7lrkEc+NirKKX1F2FJNwNrv1UysBXv9iqeNJO
 tSEjlbchhxEI1va/BC61f4By453pr5tHmW58uCMdBwXxxFZ3yt9az9LrIkQkLnnDjEdO
 XJhYPPkgd0ia5lfLp8XZMGx21/1gfViurWGrRCpS9yf4nB68UidrPnJNgoQ82w8TTgA7
 b9eptWVY3cahwHRPLgPp1UxpwUzbXPikJhT3A1GC+Ci/RJbu1puMz1jV+xVIGsMLIvf5
 wToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793803040; x=1794407840;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nC3nKpYt3tZdvI67lBrJocJ9PQSRSlMVg1vYJbFrszM=;
 b=EeUNHWSlhB/Vhkg0v3huu2BOXBIbf9yBgWonyeMnjcFkjKa/KeHRnBtvoOt+Ux9I66
 rSIuaF1hIaZg7tgyHDxQ7SPuRQCs5ZkZiQ6MiZXZjsuZKpcv/9J2428HKpy/iIBrymOZ
 84FEC8FZRe9S76DBjxSy3BA7zWDQ/SOqpaizQ9YI8TwWTUoyBMOKJMElp2Lzq39GyEsz
 cC05AMxH3VbuqzkjDHCroIdjICYGGirv/zm6UwnGlz6n+9GniXt+Yj87opy8VQ8ak6M9
 S362s9FBcditnNUemdPzH2mVWoI7LBVU+KGicJLB/wAqOrLSNRHphgjG8b8VfV3dMLlV
 Fp8g==
X-Gm-Message-State: APuU4Z9vWMIwvmyQ67H18tuBidJ5GzdryUlfOjrrigkmj9TPeyyMxHe7
 Tni6bGDx04ZywGFJDUQXZIHfYAoR/7eW+kheY4IYY24vOhB51Rr+1eYozhbctkrpB+r3QqU1Gd/
 4kFfRQw8X3Jdhu8PO3/fWpkkizr5O5rE/RPZEJkJMofoy+VfFyHpybE97czvXE1BjxJCofLZ2po
 tg/aFdCJrQ
X-Gm-Gg: AYBFou0e5d/4OvnAVMmcdcG9W5ki6T8fuHFLLxOdjahE2d58vfnjfrNuxVSbSD3GHAz
 lNx4/xVZNIooSFuO0wCDBH+XLnblrSURCB5ClFD6jMNIZfZdsDhRRBTm7vzBh7Cp7T7ljf2wzCk
 Qwuspb7AoLrgSKATqTtGFhoLvo9IKz8hgWcRqDXCP3rEe6xKttkMbleNbFQb5rc+zuY7mQjGHTp
 j2uoBhdC0QLNj2abuZZM3sQJ+8tk6KW73+nQHBys7xm+RYWW7lmzEZ2WOUWvuB8Jg2+aqaxR4Ey
 E3E8LHfs471PSthv2zBVbbQ2QOA72MNNc/39Ofn8xCQlxAxoYSoHbDevGfRYWtJwgdPD6Ia+Dkg
 9b+P4eYG+Fn2xidJ0zhkuNl/FxomJPtiv5bXFI2EbpPBEatdOX5SvECTVKBH6zC0MQo3ffvyhai
 CsGmIYFerNYhWMhmvaGKUlW15EXp8MFcEw33r4xx7dsfZA9cdQALphvzUav96s+K51xLfNgOUGE
 3lLFCZ73GEZhYo2D/B6ypWs3FHFskaYSsKGQ8VqfiMx8LyEUdjdkbD/F54RV9YeFvEhcStB1uFI
 mt1FHyCZ5JVDKezydM9MA1JRHf/JXFcQLkYrMT35EjIv4g3ydcuARV7aJtxnRlEj597wArkv
X-Received: by 2002:a05:6a00:4207:b0:886:73c9:89d7 with SMTP id
 d2e1a72fcca58-8a9bcff6a53mr13402997b3a.11.1793799891081; 
 Wed, 04 Nov 2026 05:44:51 -0800 (PST)
Received: from ?IPV6:2001:ee0:4fc2:28e0:c9cd:d5ce:dc4c:abf1?
 ([2001:ee0:4fc2:28e0:c9cd:d5ce:dc4c:abf1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b09b66155dsm962053b3a.42.2026.11.04.05.44.49
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 05:44:50 -0800 (PST)
Message-ID: <427cdc9c-531f-47fb-8d56-f9e3a9d9dd4a@openvpn.com>
Date: Wed, 4 Nov 2026 20:44:43 +0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOc7B-000000003K3-3fWl
Subject: [Openvpn-devel]  IRC community meeting summary
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: Johan Draaisma via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Johan Draaisma <johan@openvpn.com>
Content-Type: multipart/mixed; boundary="===============5246350850435828474=="
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--===============5246350850435828474==
Content-Type: multipart/alternative;
 boundary="------------D8ZzrQ0ml1UFdP8eNhF4lyzh"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------D8ZzrQ0ml1UFdP8eNhF4lyzh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 4 November 2026:

  *

    *Updated: 2.7.x release*
    Version 2.7.9 is expected to be released tomorrow 4 November.
    It will again have a number of security fixes in there.
    4 weeks following that yet another release will be done.

  *

    *New: add openvpn-rfc repo to gerrit for reviewing*
    Currently changes to the OpenVPN RFC documents are reviewing on github.
    There is a strong preference to do this on gerrit like other
    openvpn2 patches.
    uddr35 said he will look into it.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------D8ZzrQ0ml1UFdP8eNhF4lyzh
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 4 November 2026:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            2.7.x release</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Version 2.7.9 is expected to be released tomorrow 4 November.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          It will again have a number of security fixes in there.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          4 weeks following that yet another release will be done.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">New:
            add openvpn-rfc repo to gerrit for reviewing</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Currently changes to the OpenVPN RFC documents are reviewing
          on github.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          There is a strong preference to do this on gerrit like other
          openvpn2 patches.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          uddr35 said he will look into it.</p>
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

--------------D8ZzrQ0ml1UFdP8eNhF4lyzh--


--===============5246350850435828474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5246350850435828474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5246350850435828474==--

