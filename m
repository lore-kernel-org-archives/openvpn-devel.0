Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C85CD98E2
	for <openvpn-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:
	MIME-Version:Date:Message-ID:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DSj2vLFaf1TifweGbVn3fIq/xhhR0PJEkF2cy09vYu4=; b=U1EOaSfLsQZv/KRg1VyuJgHwul
	l+5Gg6ll0OELAPP5tHsyMrGpnpGgyS8gXAx+1xS8XYtataN/SCNHETFTt09NjpIbzqFasW0ajIKCQ
	9L3Fv+RK8VTU+7mWvo9DREPlYXjvdGg3lAe3bKDlI4l9SSDV++CuTos78HISUL5TMGFs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wZrYD-0003C3-RP;
	Wed, 17 Jun 2026 14:47:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <johan@openvpn.com>) id 1wZrYB-0003Bv-9v
 for openvpn-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 14:47:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Subject:From:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F7uwDWJnzkSblihFSoxiFKFpXxQLgUxHOgt92Zzb5ns=; b=VO7+P2TAm7NdU2aG752lbvnX1P
 5Awk3LDhnutabZzmyrFckGYKoZqN9evudFQ7ySajlxvCGeKHrUmmmW0vMmLkgIonjmiB2t7YwWwie
 zB9nL5/uncpefSq9xOs1xEb65Qc4Bzv71ZXYVTbOTNDsWPS9rcUUa3qEnsgWuyiw1Jvc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Subject:From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=F7uwDWJnzkSblihFSoxiFKFpXxQLgUxHOgt92Zzb5ns=; b=Y
 CDLg7sfQV2csshFf/XKuV/71eh8Ubh4OWSvXdjF1pQdDDlThTqWOv70lhVYDSVeY+IxRtK28f/TFf
 vQGexP/5WdREvPRv4Rv7I2Q4DckVF1L3wOHZ2kr7gy7KK/KXNKWXyy5dQntDrsfdUYuIaolajZS7Y
 He5teVE9UKpDGOAw=;
Received: from mail-vs1-f46.google.com ([209.85.217.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wZrY6-0002UV-Tm for openvpn-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 14:47:28 +0000
Received: by mail-vs1-f46.google.com with SMTP id
 ada2fe7eead31-6cfdcd6dc43so4243373137.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 17 Jun 2026 07:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1781707636; x=1782312436; darn=lists.sourceforge.net;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=F7uwDWJnzkSblihFSoxiFKFpXxQLgUxHOgt92Zzb5ns=;
 b=HNAQQoaGOlfB1sjcgoxwwGy/hI0bxS1PQs9/XBoq7dJGibYiBrzxEyOMjYDsugY7bu
 QTJTLGb262BzBClOBELk/mnp9qryGI/L8v+ScimpjfF+vxh0kmV+rWqF7lhzny0d2om1
 Ikw8dBLF/CkoscKBNjP8ZCtYBDNTA2WEOIBhx3ec9mMUweyRcaiXYtBwzooeh5Qtv73W
 YFc03wi3CawBpubAawN32kkMbzezdSIQipeAgpV846+HvliCQWxBtYWUxbCHqOwbSSsm
 e9Q3Lt5HNupo393ci+6ebKhduUMh6Py8K8//AKMizmJleg3tPwqGg7Ojseo+Vk47Xsfs
 FnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781707636; x=1782312436;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7uwDWJnzkSblihFSoxiFKFpXxQLgUxHOgt92Zzb5ns=;
 b=evG5sHGL9TMSdJMnk1bGan/LyliQ6DCLk7J9hH34DHXsND04fQIOST2xsThLnKzatj
 p2g3mX0GGTgZiDWTeYDTMmuHTsMIGJ31uAxP/RMndR4lrtKGnzA5GxULfk0KYEsLnh5t
 o0BRdNmt1uXqhi9ziUab/sPlgdildXmW3BfP6lW9VNzYdT1HLv01xZh/ZuiHDx4Tc1QH
 V3uPAUr+jH6/B9u71HR8r/yCWh7luQ9cIrzQ52KvK1wC2LgI43bM/BuJ7G1ruY/S3mol
 AWbZhcA+nFRDxasvhtnW0uwG5vI3pSc/Uzj8b8cczMi8Ib4d7MDs3AFo2M2hLJ1p7V/H
 9g2A==
X-Gm-Message-State: AOJu0YzG3rCm7/5D6IAzK+L7FExginuDVAvTMtUNq7TPxmOZfXcsvxNO
 N2BuLqUqBQrHl1wVgpJQL9gxkOi67Q8vvLt1B15Yk8TcQrhSeKHS7snV/hdgtJe/hQ3q6L76Icw
 wfTyLT3TqH+sQ27oRZMfkhOfTrPtvM/oc1MhguSXi8PB8l0A8iEFo9is1/NyvotWLAgNJh1gPBe
 Gi9wwb9Q==
X-Gm-Gg: AfdE7cke3vm5+y0EVQ8N5Kd5JS7U/880OPUGW8rbA+CZMTBqYxcMCFZKNDls4EmaMJb
 +OMN/erz8IBPiBU4yfQsbDzr9ibbQy0/0p2WswbnLhqD1HPComr0wn6lhbOGCR1hbh0XnKlZIlg
 MSfKfjYHTf/Rq1trlK2T5VZcJHOokVauecMqCfTEFOW/59gon5x6fe+O6xbSXcNm5msyGGtpwI5
 sg3gRFHDIw2Bvi0OY1Echgsq1x+zfL2XqTemEmi4HC4LyBeBsEA07nbz7jU8JGG326OXrDZWdua
 bOMR7vY5+rEB+mPodW74OTax0tqJPvlxRUAlDluk1MOqYrx2ubFiQ17Vllbkh6gZ9K1ohDjF/ik
 Rxv39s1kzcmskeky5OB/7csALPUNVgls9yb0KF8iqp0Kgwrc7IGlis1vALpNGkuWIgdlUmXxkkX
 9WgKnPckuTLB7zbN64ohqhP6PzBjT9IO2ls/W/dW4eWM1xLhMauLi93Q9iDA==
X-Received: by 2002:a17:902:da8d:b0:2c2:62ee:5a0d with SMTP id
 d9443c01a7336-2c6bc0bdc32mr38239695ad.14.1781703766059; 
 Wed, 17 Jun 2026 06:42:46 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f83:3c70:a2da:9088:5421:f33e?
 ([2001:ee0:4f83:3c70:a2da:9088:5421:f33e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42fca9f44sm174382085ad.37.2026.06.17.06.42.44
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 06:42:45 -0700 (PDT)
Message-ID: <b8f30f1f-2580-4ea2-917c-189089ed5c5b@openvpn.com>
Date: Wed, 17 Jun 2026 20:42:42 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
X-Headers-End: 1wZrY6-0002UV-Tm
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
Content-Type: multipart/mixed; boundary="===============3446509571970869055=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============3446509571970869055==
Content-Type: multipart/alternative;
 boundary="------------w2ab2l09GboUaNKiBX1vbBka"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------w2ab2l09GboUaNKiBX1vbBka
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 17 June 2026:

  * *Updated: openvpn releases*
    Currently we're handling a number of reported issues, some security
    related.
    The openvpn release 2.6.21 and 2.7.5 estimated release date was
    updated to July 1st.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------w2ab2l09GboUaNKiBX1vbBka
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 17 June 2026:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
          openvpn releases</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        Currently we're handling a number of reported issues, some
        security related.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        The openvpn release 2.6.21 and 2.7.5 estimated release date was
        updated to July 1st.</li>
    </ul>
    As always you're welcome to join at #openvpn-meeting on Libera IRC
    network every Wednesday at 14:00 Central European Time.
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------w2ab2l09GboUaNKiBX1vbBka--


--===============3446509571970869055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3446509571970869055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3446509571970869055==--

