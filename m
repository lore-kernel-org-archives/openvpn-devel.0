Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D316C5DF6D
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:
	MIME-Version:Date:Message-ID:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/iOAkx8DI5UTDyxIpriPJml9BT1bQq7nP2Ln021phX8=; b=fqDpMlGTf0ws9J8JD3LWz8Rey1
	dYymsSwvzWMdXUPEx9gt3jwP31rfoKCn4apN9wNvpV7Uxd3Ijc/1z/rGkfF6RAcQQiwMJ5HN8kITR
	EpgCVmN8Od1yGigf4FzmwoudQKBjUNeYGEnS883jRyqDkUAYP8Ew9fN5F/OUCIPwmW4k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwgjo-0001bF-3k;
	Wed, 19 Aug 2026 13:53:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <johan@openvpn.com>) id 1wwgjn-0001b9-13
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:53:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Subject:From:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QNCUCiTf702W7Lz/pmEhyB23nHGk1rKiivn7r3dQb2w=; b=Y0mZA5AGJaL2ns7xALid9XQOGg
 EmsqP9XB5QokO7G/SiAGz5SOMzUj1HCwHB4Jqu2hYVwn78hsa0/SOBqZpWjKAkw7ctFTfsmRYJVrJ
 ZHvlmyzcW6LzkhBw4vd9rfCd7cakhp48Sx8ij7tegrNCCbUK3Vh81NBnmuM+UHSmqgvs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Subject:From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QNCUCiTf702W7Lz/pmEhyB23nHGk1rKiivn7r3dQb2w=; b=c
 QhGyu9V144CRvE+Qzts+VfYB7tDHSxX2eMZfLOF4yZGM4py4Nl39QfcnyOUmtZGPSpm5tyfNrIijs
 9PnkeIwm449BEp8oTlnIfJxsY34ObE5OI5o563+bq61sV6uNIz3hCg8Unj6ixkbDRU+9CGCZ9BTEz
 emdbzNmuKJHsr3Ms=;
Received: from mail-yx1-f49.google.com ([74.125.224.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwgjp-0004gY-Sp for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:53:50 +0000
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-66bee06ff74so1620130d50.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1787147624; x=1787752424; darn=lists.sourceforge.net;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QNCUCiTf702W7Lz/pmEhyB23nHGk1rKiivn7r3dQb2w=;
 b=W5b03M1Br3uJeoJerQhtYXXDWJ4iHnqIZDRB6PPY+7KhURrNUW5QxMXozWI+lSZk78
 UaGDoXfu/QfcuIrGGa8biEWwxzMmneEmKcI8mx+jOsZlp5BnQ3uO4EDbbX4EJKQghuQx
 T3JaJuKlC3MLds2zL9WjPtAXyxDqRfBUEpTAFb5d30b1WxgWa5Tj51J9+d1tjjV0/sV+
 /q25UMcXa6PeTW6+6FpEtnvLkte2oTobbnXm/5vMIu3MFhbQ39w10sDnD1+Fdr4xNaj8
 ImiW6cORSjUwcdSEgngMkXQUGJTg0zk0UAbKlkZUviqBD3r2RwbYyCuSjPjbLiI/EYjV
 8JkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787147624; x=1787752424;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QNCUCiTf702W7Lz/pmEhyB23nHGk1rKiivn7r3dQb2w=;
 b=m1oA0JkuTBB5yMChr3Owe9JPTRm6Irio7gYyXKRUDIpRyT8E0iX7o4a9XA+qlV2fuw
 jIKIjFQiyu9gWLrCAtOQC1Av1+ktVmiVq4tZMGyTiv3/0xw2VdC+EQA4rYALJp25lrXk
 dlQctYYpE+GEv/ksATX4gcDTWxeohYTSfkxIgmy4f22PJIBeukiCzBQC89roUUTK+sDc
 uEjInj8lpMiSKgOKIvGfNGjKeqmKv2KJl9XOC8ZuZJjk7iGHmL9Bbv4m1TmfHfOEj4/N
 c/xZQFdFjcfMty9V/JpI3NYE64qBRfQh5tIisnRj68GYW+0azHWP1xsuiO5dEuV1oeH2
 +efQ==
X-Gm-Message-State: AFuF++mf18nqeF30/SrVBNGuv7N/MBS0+gmx23BPQmIRfbs+M/hlGzwS
 amroEQP2QU1uPwL0gX/nBpl3FQtw/h9HSChO8n4TBKkdktBWrB8X9BLHFcCiQGp/KfmAVVA5a4Z
 TqreTBEGISP6L9AuvC8j+Ffl1nbKVexezmswF/fOPcIF11At/pLHas3cD2DRJc5eeR7kyJisZj2
 FuhLGk6XTj
X-Gm-Gg: AR+sD12kJABGTIQEjwJ77dYACP02LceV7zzXY01qaU2S/mVjNWvwaFV+akAheQDVNjp
 SIg6TdIoRiX5LnxVsUGC0bv2M8psX3BVnwtNA305eusziKB2ZiHCoHDQxL7MnIETR2JtXIGTENj
 iaNruF/poXmXKa2kjfdiO82AIALUOGCf+v7I4P7oQ8fybT6fWCK1FskPITOcfg8MitBx6OZMCK+
 Q99++1jebO6AeTVw42rZx6aZJ/z6/HLs7zR6XdW0dX9lGOKO/mAFEWL8TQsZ3tC7WgM2eOb7ryk
 uZ/1bVYs+6Iyggszn2hZAuAqC/qN0L5l4IMV6zkGEKTCUDvRzzbOUdcrK9PcGD9N6oF6/JA5Vsq
 e4JVkey+kK93Nnr9zjedDpLIb+NcI8CVCMWkkrqCyCS8zoB9/0HXdjuCpH4P5Yw36efnUMsYL4e
 3O7NyuwC7PQ6EoMlUV7E9idnrZWUsMOW8vMCW4IJQddnUzpwaqakOGmA6JjdiFPMJVmFTvOqYtc
 rlBo5tirQyYy4mafOUrqBBEBQej3j2ldUZ6QgrRjFzM
X-Received: by 2002:a17:90b:3805:b0:390:b41a:b92a with SMTP id
 98e67ed59e1d1-39580eca128mr8000591a91.4.1787144319154; 
 Wed, 19 Aug 2026 05:58:39 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f83:3c70:9d0a:4d05:17b7:debe?
 ([2001:ee0:4f83:3c70:9d0a:4d05:17b7:debe])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957f8b28c1sm947361a91.0.2026.08.19.05.58.37
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 05:58:38 -0700 (PDT)
Message-ID: <ebe24695-cd66-4853-a52e-61af4ebab3c0@openvpn.com>
Date: Wed, 19 Aug 2026 19:58:34 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
X-Headers-End: 1wwgjp-0004gY-Sp
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
Content-Type: multipart/mixed; boundary="===============0896355276982169549=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============0896355276982169549==
Content-Type: multipart/alternative;
 boundary="------------WQ2eoqdJWaPgVfzgDhilALAM"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------WQ2eoqdJWaPgVfzgDhilALAM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 19 August 2026:

  * *Updated: 2.7.7 release*
    Currently we are aiming for another release at around September 2.
    There are some small security issues, mostly Windows related and
    involving rather unlikely scenarios.
  * *community meetup 2026*
    Coordination is currently taking place
    here:https://community.openvpn.net/Meetups/2026-Paderborn
    The date is around 17 and 18 October, location in Paderborn, Germany.
    For the t-shirt we have some idea of what to do. Will check with
    designer if he can do it for us.
  * *Updated: Amount of open changes in the queue*
    OpenVPN Inc. and cron2 reached a deal where he gets paid part-time
    to work on OpenVPN2 code reviews/merges.
    We encouraged razvanc and chugly from the company to get involved in
    the community as well to speed up reviews.
    lev also promised he would spend some more time on reviewing, after
    his vacation.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------WQ2eoqdJWaPgVfzgDhilALAM
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 19 August 2026:</p>
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
        There are some small security issues, mostly Windows related and
        involving rather unlikely scenarios.</li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">community
          meetup 2026</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        Coordination is currently taking place here:<span> </span><a
          href="https://community.openvpn.net/Meetups/2026-Paderborn"
style="box-sizing: inherit; background-color: transparent; color: rgb(24, 144, 255); text-decoration: none; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"
          class="moz-txt-link-freetext">https://community.openvpn.net/Meetups/2026-Paderborn</a><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        The date is around 17 and 18 October, location in Paderborn,
        Germany.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        For the t-shirt we have some idea of what to do. Will check with
        designer if he can do it for us.</li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
          Amount of open changes in the queue</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        OpenVPN Inc. and cron2 reached a deal where he gets paid
        part-time to work on OpenVPN2 code reviews/merges.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        We encouraged razvanc and chugly from the company to get
        involved in the community as well to speed up reviews.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        lev also promised he would spend some more time on reviewing,
        after his vacation.</li>
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

--------------WQ2eoqdJWaPgVfzgDhilALAM--


--===============0896355276982169549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0896355276982169549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0896355276982169549==--

