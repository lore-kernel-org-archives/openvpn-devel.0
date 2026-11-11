Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5141606A338
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=S23xiSrH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FFbNeRlp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=J1SdryTp;
	dkim=neutral header.d=openvpn.com header.i=@openvpn.com header.a=rsa-sha256 header.s=google header.b=tmcSs5Cq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:
	MIME-Version:Date:Message-ID:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=YIUeXN9O2C3uq/L2mdBPNbYC8M6RjBC3j6sZSfh2o7I=; b=S23xiSrHXzUO7aKnIpvoMszn5+
	3iv5OWYV7lrxDxsEqp6Z+sWTuqD/+KnggDTx554hgXWhVV6NSIXUI2rFsXvW2oZLeyhhNl8mAQ6D6
	lE2PFyehdhFu5zuzD+03u6ExpBP4TZZFngf1qb17AgZWHezCnK5x0izaXtFv5EZF46vs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR8Ya-000000001Nt-1F3C;
	Wed, 11 Nov 2026 13:40:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <johan@openvpn.com>) id 1xR8YY-000000001Nm-0oRy
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 13:40:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Subject:From:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+5StU1tA8l906Mt5iHqNha3ahMMQ/haUsfdxUeuq4ZI=; b=FFbNeRlpvTdParETTOHbH/kNYh
 NSFwFbBhN0DKJrv1PV6wb0Ky44hpT+4GYvVE6uA/Jeg8T58f3zvGNqAy7EfI3QMIm3pk7KLKf/Dfw
 uiAZvkbee4sbOJ8pFmFFiv4Y0gKZQtuRiafR3o/Soxw/4FdKV0+4Tu9izfXeKxf0V3VU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Subject:From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+5StU1tA8l906Mt5iHqNha3ahMMQ/haUsfdxUeuq4ZI=; b=J1SdryTpYFe4pnqz3Xzk0k8/hl
 L40iUCD2NCKoBS9btZOfFVtiMbxrF6ysBS2CjAUOSNjfzB6JCbAGvKneWsO/25XuSakZLbgnTCwrB
 ZK3iFio+YEbKnai+pueadsLdNCN+HMRl1I7UO4tqgKw08+5dJBAUeJ47h5r4drhNPcnM=;
Received: from mail-dl1-f48.google.com ([74.125.82.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR8YW-000000000lV-25oX for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 13:40:06 +0000
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-1931ff67a29so4981338c88.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 05:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1794404399; x=1795009199; darn=lists.sourceforge.net;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+5StU1tA8l906Mt5iHqNha3ahMMQ/haUsfdxUeuq4ZI=;
 b=tmcSs5CqL5JJQvfvSJsfXgnlj/k73z1M5+vX6mxRlU6IJXCKBq3SNy2eOhD07Y31aY
 Yqteq5lJz80LlxQYXZdjYFa571+G43UxtDsYb5ZcYiyn/VDDtlxwFClBvOTMCXsiDKWT
 7HCL1oCDX8SEhEfjMBLj8K8Njd6xRhMfiLfH6zxzGcFdn7Dtr/cRX6cc4M7H9TrOFrt9
 d6psfBXvuNbZITg872hsnIcjlChNeSXN15xjOgXVcIogmXlZhEiXrzdcvhtFrMxEq4gw
 LveArC8JgDICl06z7S3eZrdRmcdQS0q2Ftydr3MJ8jBRsGarfn4CT0flgiTScYvWQnni
 aVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794404399; x=1795009199;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+5StU1tA8l906Mt5iHqNha3ahMMQ/haUsfdxUeuq4ZI=;
 b=lbPtxhfObCDKfIu/lFv46yauEocE8PRi3DYZ90WlOMPKTXuvhFSNzuqFXm332MoJvR
 zKaZ0/2YFAemARuzNP8im48jx+EowI87KVj4bk/yIhEsV26EgbMzw0Hrc23QPu3/7W0N
 etwvUei5UqiaQF5nQGGu+65xFYN9yLE4+W163QeoOqm6l/72GxvkKAcGvCNWM/On2aDt
 Gxqh6CvXy8Mf7MJiwtBM+9MmtIU96n/Y95jJa0Rc4GCptZb0HzYgJG9VYpqmINIikWEh
 p3m5pmP85w6D6ccN8ZJBs9MqJ1auL8SupWCnzvKLcVwocTSxT2u2uo7jjfJPD8mRJ1bU
 LciQ==
X-Gm-Message-State: APuU4Z8OyIsGIzObBW1QLTeWcpo2EGbgebrF4AWXK40AOrZcHwMP1Efm
 7TF0miQVCM7bDEHVBZFtLX+x+SGy9dwRlnMdBx5TwiTHOp000Ac/iNnLWczy5cfpXFNGEuBNCFT
 iEgCXjX9sehunI7EBitGuyLVrgPnXP6HeLswj0OfqSNLzqu1byb8EYpMOxXeMalfDqxVBYDzYRn
 ZR8t/a0H8O
X-Gm-Gg: AYBFou2sfE/G6kiTpH2mY9Zi8FG9Cfj6O/Ym7iq9hb1AU6Eie1HXGPXzVwN4e7dOlvv
 BxAioFz/usx9/yLuprGg+9jLhgKvJot7VJxX4Qlhee/u60pA+yWzGVJWACIULpqSL+bZ+pW3eJE
 Wslygb059UXx14WNdGLiUXIua6AKJCt72QJdk4d2Nsj+ldIVPF3KZs3/XwSYDmaRBUJUZlPenNC
 quG1GJq0WeSKXma8HxzXES4IjMTvPX+aL+eFGUS0usNiyHNWV7gWNFKeJGY2IdoYmxFsQtiTBqA
 8pNEeUZutJA+bi83Lg6t18qr5FGCkyZwkRTe4uznMkBH+VgeRjWBLK8jeq1GsFDM4f1SspdAUBF
 tZosRdr4r9fGrWkO6XN/K5bCCu+xDObR7/5fQVQTVr6EpnPGCtAuigkQyLWlmLZdltaNy6M6+F9
 tV/mBCp4FmcEmGCSOq7svBt00ObhlZDlylb8h79CO1loojkUURwiCkfyckc4O67lvHlScD6mW2o
 5mKo+g3it5SiAy+T0FTqFplbEPLyqYCbi+V69bDrUpdZcd1RH6ONtuEdvo3yGeddbjOkjAqXnjk
 5tMOE9MpLRq8n2FrCfGEFJk9TgwMKTuQcAYtbAaDu1UZRzvaImS+A/ZayovnV81jM4l9QHVqbw=
 =
X-Received: by 2002:a05:7022:7e82:b0:1ab:fe29:5081 with SMTP id
 a92af1059eb24-1b3c0311fd5mr2654493c88.20.1794404398659; 
 Wed, 11 Nov 2026 05:39:58 -0800 (PST)
Received: from ?IPV6:2001:ee0:4fc2:28e0:9c4b:4eea:2654:96c4?
 ([2001:ee0:4fc2:28e0:9c4b:4eea:2654:96c4])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3752060c4b6sm16739304eec.15.2026.11.11.05.39.57
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 05:39:57 -0800 (PST)
Message-ID: <6709e36d-2521-4e44-8a15-668794cc51cc@openvpn.com>
Date: Wed, 11 Nov 2026 20:39:55 +0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xR8YW-000000000lV-25oX
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
Content-Type: multipart/mixed; boundary="===============2946157583280384697=="
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--===============2946157583280384697==
Content-Type: multipart/alternative;
 boundary="------------X1xK7wa3OUYOUzcfZw0DgqOD"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------X1xK7wa3OUYOUzcfZw0DgqOD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 11 November 2026:

  *

    *Updated: 2.7.x release*
    Version 2.7.9 was released on 4 November. It contains mostly client
    side security fixes.
    The next release 2.7.10 is planned for 2 December and will likely
    contain further bugfixes and possible security fixes.

  *

    *Updated: donations*
    We have no official donations program at the moment, but it looks
    like we may be able to arrange something.
    The difficulty was in who or what agency would arrange the incoming
    donations and technical and administrative details.
    We seem to have found a suitable partner for this;
    https://opencollective.com/openvpn-foss-project
    Will work to get this donation option visible on github at least,
    and untangle some of OpenVPN Inc projects on there.

  *

    *Closed: add openvpn-rfc repo to gerrit for reviewing*
    Changes to the OpenVPN RFC documents were reviewed only on github in
    the past.
    There is a strong preference to do this on gerrit like other
    openvpn2 patches.
    This has been implemented and it is now preferred to use gerrit for
    RFC patches and reviews now.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------X1xK7wa3OUYOUzcfZw0DgqOD
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 11 November 2026:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            2.7.x release</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Version 2.7.9 was released on 4 November. It contains mostly
          client side security fixes.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          The next release 2.7.10 is planned for 2 December and will
          likely contain further bugfixes and possible security fixes.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            donations</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          We have no official donations program at the moment, but it
          looks like we may be able to arrange something.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          The difficulty was in who or what agency would arrange the
          incoming donations and technical and administrative details.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          We seem to have found a suitable partner for this; <a
            href="https://opencollective.com/openvpn-foss-project"
style="box-sizing: inherit; background-color: transparent; color: rgb(24, 144, 255); text-decoration: none; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"
            class="moz-txt-link-freetext">https://opencollective.com/openvpn-foss-project</a><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Will work to get this donation option visible on github at
          least, and untangle some of OpenVPN Inc projects on there.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Closed:
            add openvpn-rfc repo to gerrit for reviewing</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Changes to the OpenVPN RFC documents were reviewed only on
          github in the past.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          There is a strong preference to do this on gerrit like other
          openvpn2 patches.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          This has been implemented and it is now preferred to use
          gerrit for RFC patches and reviews now.</p>
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

--------------X1xK7wa3OUYOUzcfZw0DgqOD--


--===============2946157583280384697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2946157583280384697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2946157583280384697==--

