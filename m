Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3A1C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:
	MIME-Version:Date:Message-ID:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=b1VkLoN0bmRCXwpN4Rjx93ebBlM9jenzv9L0kdMyW0c=; b=UPcoixuXcH5dpzI71WvJfJfaLL
	fk53ur+BHgS6By5AtPN8OifeeCiy2Tg0j4DoavjzslkNOV0/+B50+0X3XLp+0MC1kjxiW1MHVlNGF
	dAMR37U+H+2L2GssgdTuR++hSRDGPOJ0QvdWDXccKen+A4/leLQCGbAafcvHaBlg7fIA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wevUJ-0005fm-5x;
	Wed, 01 Jul 2026 14:00:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <johan@openvpn.com>) id 1wevUG-0005fe-OO
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 14:00:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Subject:From:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0tPPtSHl7T2U4AZ8oSGsiY0A1KTskLUn+d+LwW5nZus=; b=UsVtJdayESTWf+qZbD533kGbG7
 EynNzTOexRfqUoY+vWNLkaWBCibnCpN4clE+MQPe4HtU/uZO9dE/S5dC0QAqlxUMmAk5oxjSorwsT
 AMDfncxahZ2Pc2O1dPmrcAxKRK/hkbb3SS+RUIRk2d45hR8dVNHYWuHJV/TUG4kgBo84=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Subject:From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0tPPtSHl7T2U4AZ8oSGsiY0A1KTskLUn+d+LwW5nZus=; b=Z
 IXoi1b1iJomRv2fkYgYclAwWaHWtkOBNWn0Y+lu2HuV8G/Ixb2u+x0pE9ddzDpm502rgM9L8p0fzQ
 ocCP90HSGfqHZJdIzrPmLMuw1k4wzeQFGnamm2Gacr+KbY51ovadYTDfSe5wGJkIf6IV+LoPde+qT
 6BXkgSBYlOUmYDTs=;
Received: from mail-ot1-f43.google.com ([209.85.210.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wevUC-0003FD-DH for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 14:00:24 +0000
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7e9ccbb7aa3so548110a34.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 01 Jul 2026 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1782914410; x=1783519210; darn=lists.sourceforge.net;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0tPPtSHl7T2U4AZ8oSGsiY0A1KTskLUn+d+LwW5nZus=;
 b=guRlSzff98yTIeJZMMBBCU4GNL9RK0+1RI8uzCZxaObW6e2ydzql/J+869vgUZjAzN
 cX0hcUmhZqMVU4VtKz2+B9As/jepD7AaXhdxpmi/+RRLoj7alBTmjDbAzCm7/II4C5Bm
 lcdbbC68gl5KKA6WSR8GO5a6rbHyFa4Icmaj1+VLZIV+r1BT8LWNNtNR8H4Lj2qSOU07
 UufyGh87ArhSOc4aHQB0DbZnBwR07b3sioR8VYP+3YLA+1kgQOqYP8Iv/B4hBZCm7u8h
 YL0H6H8D5GnFSJsbvNN1AsSfjVSDec0h+A5vXlvH3zRSHDE44tkqCaLPtrXuyVdVKpyd
 0O3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782914410; x=1783519210;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0tPPtSHl7T2U4AZ8oSGsiY0A1KTskLUn+d+LwW5nZus=;
 b=sJx0Bmayuprnr1iW3byZkgqfT/JK/JoLlc2rMGqTk+I3wsQArePR3KzbIlsAvDnwoZ
 Cw1dq1LY/GGpMUpCNWUwWjYne4RNtfgBPGff2C318fHEik2Vrp1Qdtcinpg3zqywatgG
 4k01HhZoZodGN1O+Nz4172HNk9yN91uBNrl4wYtf3iJqkIeVocjbyhIfLRKTW7ijVpGH
 pRwH27FCiWyzvAC89QUt2nUCjlhHnkbgmKRJOeKLjJZJZgoIwnfKPFuX2+VZ8mE9H+eI
 qVuX9p5BuwZpgw9Gq9pn4I9CfXTAs20XCpcPyuK8k8gWoeF7WYLUdQ+gl9k0rthULr0F
 KMJg==
X-Gm-Message-State: AOJu0YzXGJrMgb0ZCVAhZesaNmz4twKCoYnNfQgDpUUve098S18MmP4j
 JVutOs/ZPn78Nq2f2RZ2aXe0ZwnCL7GtU8AX39F2JoCaQrG2ApFyea4ILB1XN0+KzqcHoWesb0c
 qaJbxby2rBVQCEzsvW9A3KKYJwRonfe/F+9JAevZA6a+b7x2+N9TjA7U1rV+wQFXSgT8VVozyDE
 2pFx7dGpTH
X-Gm-Gg: AfdE7clTioiVp05xiHOrseZYJBJRuDzyCfwHPlzxXpvrQfhAyxtQLyKUTVcI8WSqgws
 hfnFI2IZHItVB6tKqgz6Ea1BPFjZWiAdCY2aXzNvcRnR5wXtbU3hF/9OqIyjUQFFMeRknV6WrLq
 kjH7yxCz6U9UQOUGt9rqoZS/nbkAocWeu45oMbGq7qilSibS7FWyLm8n0w/NMHuCs9FivSoa1KQ
 nZxpU9n3iENkgFQncEH8MepXisCb0ot9PCW0Ovh0VG0SHQYXMD9/l7tPEXWwlDT/Hl0JIB47wep
 8K6Xee2aj7Wh1PPcggWLrF96xPalmigh/QvapyzfUPo8YoOB2DF5j4kkrbjmu3Eft9SPOE8kuqV
 lzK1F0+adgf+dlxSu6U9v/n8hhQRgzvDaRtgrj4TFmi/OoKcVW64QJ+KjZPjHucrgk77qw9GLGg
 C3qMKPKLFYwRt6+qFN0Dzk5FzUWtLDgNpECv58jHno2AXpiACBanblyUeWLQ==
X-Received: by 2002:a05:6a00:b46:b0:847:7f7a:dd18 with SMTP id
 d2e1a72fcca58-847c4ffbc09mr623899b3a.3.1782910729735; 
 Wed, 01 Jul 2026 05:58:49 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f83:3c70:a4a9:db6f:f725:4748?
 ([2001:ee0:4f83:3c70:a4a9:db6f:f725:4748])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847a03a2a9asm4061841b3a.56.2026.07.01.05.58.48
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 05:58:49 -0700 (PDT)
Message-ID: <06bafa36-9ecf-4569-8287-21ed2f296492@openvpn.com>
Date: Wed, 1 Jul 2026 19:58:46 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
X-Headers-End: 1wevUC-0003FD-DH
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
Content-Type: multipart/mixed; boundary="===============3430630241901149370=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============3430630241901149370==
Content-Type: multipart/alternative;
 boundary="------------KZSKL1q5qGqYj1VORQYvmdIP"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------KZSKL1q5qGqYj1VORQYvmdIP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 1 July 2026:

  * *Updated: openvpn releases*
    Several reported bugs and security issues that have been reported
    recently have been resolved.
    OpenVPN 2.7.5 and 2.6.21 will be released to address these, today.
    Some important fixes will also land in 2.5 branch but these are out
    of support so no official releases will be made for 2.5.x.
    There are more issues being reported and evaluated, as seems to be
    now the new standard with AI.
    A followup release is expected around 22 July 2026.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------KZSKL1q5qGqYj1VORQYvmdIP
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 1 July 2026:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
          openvpn releases</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        Several reported bugs and security issues that have been
        reported recently have been resolved.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        OpenVPN 2.7.5 and 2.6.21 will be released to address these,
        today.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        Some important fixes will also land in 2.5 branch but these are
        out of support so no official releases will be made for 2.5.x.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        There are more issues being reported and evaluated, as seems to
        be now the new standard with AI.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        A followup release is expected around 22 July 2026.</li>
    </ul>
    As always you're welcome to join at #openvpn-meeting on Libera IRC
    network every Wednesday at 14:00 Central European Time.
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------KZSKL1q5qGqYj1VORQYvmdIP--


--===============3430630241901149370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3430630241901149370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3430630241901149370==--

