Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D3FC43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:
	MIME-Version:Date:Message-ID:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=H4Mh1DspGvoTEW/GsZXK/SB95eZBxPz6m2kYMEH4DDU=; b=MBbOyJsBvjgG2KaILa4IFFmZjK
	2TjJKIu932cJ7FlNeGNSeghvsBAj0W9VW5sKTcMSkJt2gQFhuknZYOxQONXRsgt8l+QCR+QKuzjif
	p1LV5BLvVDaA2UFvt1TZfKcHyD3mDOD4IQluFw6EXjlv16Wgi3YRLEzDubAnB9nUz4+w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whTTA-00021L-M9;
	Wed, 08 Jul 2026 14:41:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <johan@openvpn.com>) id 1whTT9-00021E-F2
 for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 14:41:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Subject:From:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5/qSjXO9NszlHxFaKML1e8Zh4oqwZpS6XqCwfpRuCCo=; b=ByIRDXZnmkMkX4npHYOmpP+pfn
 V8HaGNFQYRkidIcd+ibj6VzbyLNthc8Uev+lWKC7YEevYFZhvONganxw/NULFD8uiQdsdckJmBlj6
 DQ8G+ou5+BhI0oqAAC0eeYfoUWSG/O/bumavXw6nnFfz4oQkn8HJkcsJErXNvh/eWScg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Subject:From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5/qSjXO9NszlHxFaKML1e8Zh4oqwZpS6XqCwfpRuCCo=; b=V
 gaGDsv+mcQ+AVnizHeU9tDUcHEKXi2D+dvLcREXPkvo4qcdUB68WUDQn+dHfRSyiU89Xp1e3b3d11
 neJG7/2VNjh+0i2X3VGkR2IGDTVB71pIJR/HYJPZD4wQdf1aah42yKD4+8IzWattQHBGtVZ6mBxpu
 s78I4BxaYbOoGAyc=;
Received: from mail-oo1-f49.google.com ([209.85.161.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whTT4-0004Ci-34 for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 14:41:47 +0000
Received: by mail-oo1-f49.google.com with SMTP id
 006d021491bc7-6a31efdda0bso906341eaf.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 08 Jul 2026 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1783521696; x=1784126496; darn=lists.sourceforge.net;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5/qSjXO9NszlHxFaKML1e8Zh4oqwZpS6XqCwfpRuCCo=;
 b=r+ZQBckc/oxuPLwmNv/5dqI2WEJxY+rIOvV8obGMxV2jrii3IqwnwdWCzI8ntBjoZ1
 lmKIGkThnOPoiD56NiRAl7bnZmrfbHmUWw0a+4Oat7yOYWf/FW9vdufd2QJm8cySkyxD
 n/g9drBpFDRaeFZRG2YsicdBj9eGa3eF3IRN5Cu4c6k1DptDlUpS5LSYKUrbrx7nqwhp
 F1Qi4j6VAlgJYW2IHUYbBIvwPWjudKIxFC9fURZPK1jMEmOan2aON81bY3gUtVELvO29
 p5BthavR0tHX3Luvt55PFDHUwm946PU407K8V/UXUscKJc30g+Uer/txotOr+0MX4F1b
 bYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783521696; x=1784126496;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5/qSjXO9NszlHxFaKML1e8Zh4oqwZpS6XqCwfpRuCCo=;
 b=jiMvmmf3ASVU3sQSWXzrjfJLHNER9U2FEVOpJ7DFlEe/mQdfU1+SKQEEO4ZeDFJdgj
 m3K5DWrPbrns5G341BIAbKhZ10/RH+fZPkuDkbTAnn0xUzJgWsjXsrCgcJpjzMKasjCi
 EO5oLvQYKJO744BT9wClwKSySZiUELMvYpeEJ8IeJN+lNs+UMwOHHGUvWM/RAVW/hRNM
 NI5HEyHhwRMTd/y7sJ+VoddvzjxWHgPPKyx2YlhAIgiXn0XvCTJobJOR5zcgl6r1uZ3X
 bxkYRHKlvRpTGYeJ1zxeKagOjDE3NmbVyZ3RjaTVa9fLxxOO570+7etQN36r2KuKtFEh
 jqqQ==
X-Gm-Message-State: AOJu0YzQ6F37zc2T+ZBEaezKwUyotX1pwo7VXstcbj1Cmwj4sv1sDDEG
 l/nKyFtZl/mNdHRoDA4V2r20s77VlCgQbgRJ9jgbxtEb5gRhWLgPHvKJoiw4kfs1yMprwjlbP9s
 vS9j74+fkN6wtjNgRze9U5FbvsEnRNM/j4J8ZVno6Zs59LaSohiEHky8SyZuuznJ7xzKKzp5qBn
 d37Fp+4w==
X-Gm-Gg: AfdE7cmcGSErZSclDwFinj6IglkJmj70XyAVFjFazQng3aZAyvROJ+Myeyq9opna4XG
 T7Jk9pGY4CO2IVKBLqRR+bqlm+sLWl9Xo98/pBRcpgi1ez2epH+3ZDeCyLxWPQOF6uhheCCAUax
 rH30MFL9HN67IuTJ+UJrgn8/yUqy9GPkhk/ardWfdJGpcJzSbdZOFCD3fpV/1tiWYFqEty72yLj
 vl2zSZjCzOnjndoyuJvU3w06GzhcTmtMydOkeEZJLTDg4Bzjrk7TvEaxDZvuYTWgFdpHu57eXv+
 f7B8beEUbjFHHfEKAXvi40/CbVmZJ3gMWgx1zkOlzmgKfxD1l333IRCrS1T/zhGa3N0e5ByU5nd
 GWIKn2o+Xq+SSEPXnn7onTdv8uD0W1nikNOSdc0S2/B4ieE+AleH8N3cdLAlUSMZCLIMGDnDy83
 iR5kJxk+owvEiW3UkywdJclHoTUM/YUxDxGQeNRYQL1v3bK6N/h58Yo+TTCw==
X-Received: by 2002:a17:90b:2787:b0:37f:9e21:91d7 with SMTP id
 98e67ed59e1d1-3892f2f7d4dmr2676569a91.14.1783520126955; 
 Wed, 08 Jul 2026 07:15:26 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f83:3c70:9e0b:5f3a:2804:9224?
 ([2001:ee0:4f83:3c70:9e0b:5f3a:2804:9224])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-387d3a65609sm2818423a91.14.2026.07.08.07.15.25
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 07:15:26 -0700 (PDT)
Message-ID: <1b8acd46-75bd-4929-ad35-5b196cd43b3c@openvpn.com>
Date: Wed, 8 Jul 2026 21:15:23 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
X-Headers-End: 1whTT4-0004Ci-34
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
Content-Type: multipart/mixed; boundary="===============5527455667252004928=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============5527455667252004928==
Content-Type: multipart/alternative;
 boundary="------------nc5R7G7xW2jDmnLyysDtAb0w"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------nc5R7G7xW2jDmnLyysDtAb0w
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 8 July 2026:

  *

    *Updated: DCO testing*
    ralf implemented a test system for DCO kernel module. He added RHEL
    platforms as per discussion.
    This currently tests both ovpn-dco-v2 (for 2.6 and older openvpn)
    and ovpn-backports (for 2.7 and above).
    We recently had an issue where Debian12 broke something for us in a
    small kernel update, we will now be able to spot this quickly.
    More
    details:https://community.openvpn.net/DataChannelOffload/CI%20for%20DCO%20Linux

  *

    *New: CVE handling during holidays*
    Due to holidays, temporarily evaluation of CVE and assigning IDs is
    postponed. This will be for approximately 3 weeks.
    Reports will still be able to come in but determining if it's an
    actual CVE or not and assigning an ID will have to wait.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------nc5R7G7xW2jDmnLyysDtAb0w
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 8 July 2026:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            DCO testing</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          ralf implemented a test system for DCO kernel module. He added
          RHEL platforms as per discussion.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          This currently tests both ovpn-dco-v2 (for 2.6 and older
          openvpn) and ovpn-backports (for 2.7 and above).<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          We recently had an issue where Debian12 broke something for us
          in a small kernel update, we will now be able to spot this
          quickly.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          More details:<span> </span><a
href="https://community.openvpn.net/DataChannelOffload/CI%20for%20DCO%20Linux"
style="box-sizing: inherit; background-color: transparent; color: rgb(24, 144, 255); text-decoration: none; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"
            class="moz-txt-link-freetext">https://community.openvpn.net/DataChannelOffload/CI%20for%20DCO%20Linux</a></p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">New:
            CVE handling during holidays</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Due to holidays, temporarily evaluation of CVE and assigning
          IDs is postponed. This will be for approximately 3 weeks.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Reports will still be able to come in but determining if it's
          an actual CVE or not and assigning an ID will have to wait.</p>
      </li>
    </ul>
    As always you're welcome to join at #openvpn-meeting on Libera IRC
    network every Wednesday at 14:00 Central European Time.
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------nc5R7G7xW2jDmnLyysDtAb0w--


--===============5527455667252004928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5527455667252004928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5527455667252004928==--

