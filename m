Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388B4606A331
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hAuQzxU2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DpqwyNY2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UMYsgcR7;
	dkim=neutral header.d=openvpn.com header.i=@openvpn.com header.a=rsa-sha256 header.s=google header.b=aDgcSoUM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:
	MIME-Version:Date:Message-ID:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=gzYdIMs/7Gke6zGdtnTqAEXFwqPG6IxdRA3z/34mQ7g=; b=hAuQzxU2mChbipEUBz0TgSrl5R
	qYue+DMo0NfWLbtGwYXDHXSOHy48Fs7NTFwKuv24t96dmzMSfKq19hqASBR89mAs97sBqSPKPaARS
	2ysuf9zFqI04AmiSab8HrIjlRUDoxoh0wkIM72ux1mCJC5YX87Gs7Hv+sN/K/aRs4Y3k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xThw2-000000005uO-29YM;
	Wed, 18 Nov 2026 15:50:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <johan@openvpn.com>) id 1xThvy-000000005uD-2xOp
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:50:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Subject:From:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z5NZQpKQ/QY1LZcZkhGbEki1Szvga1AEoVrZ07QVNrA=; b=DpqwyNY2bU1etoWEV6CgVUNIF9
 Od17+t7D+IcMiPwt8YCFZs4n0ZHnk442+3qJm24tOAchABXqKPi2VzkqcyLo9t8DZ51fePtg4c53Y
 w+bU8j68pcEmXFkXjRvb0kyMMDFdc30R/XcMhdIj8P3o6WIT07BPtrUOLuuuwRONfaZU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Subject:From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z5NZQpKQ/QY1LZcZkhGbEki1Szvga1AEoVrZ07QVNrA=; b=UMYsgcR7gMa7XSTV5mifmWR1WH
 /RxQEu2wQ3jJ1OlXQ0VFh03A+BTb/qsvrSJuMnoyWlEAiq1QtRIH+0ie+T5sMmUPy2q8f3C4E+Mqs
 EHJwKU2go0ev7rqMj4ti0D3KBOx9OzReVu3wDy8ZSei1SIO6kvDG5SlTTRYPr2COJw6U=;
Received: from mail-qk1-f175.google.com ([209.85.222.175])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xThvw-000000002z1-0gTp for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:50:53 +0000
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-949680e6d83so113074385a.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 07:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1795017046; x=1795621846; darn=lists.sourceforge.net;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z5NZQpKQ/QY1LZcZkhGbEki1Szvga1AEoVrZ07QVNrA=;
 b=aDgcSoUM5K0xXwuharEfRwXkwhpKeoR3/UKkFk0zg/Lf3oLeSX4Xrcqhk+gdDwcG6q
 XIQWcmzx6CZz9haNVrMmhUMZ1KPzV6pNgeF7b0TqsqJWwxaBbhi/gq5KDJWi8WH26Gse
 Fp/9giYLaJ4m/w5mMIZc9ElVwpJuMGBBivlRyU843b/JpLplq7ujdzNyXPy9gq2z5bn6
 bwtK/D2KU3dLC/GS02U4PX6Qb0xcE6zap4jdGyFf4heGwWz5TeXgqjr/vDSFsn4UrefW
 1NNnFY8VWgOrZhyw8Rh1+SiI0qGKY59p1R++jUM0dfhif2srgqv8WHxzKnTOPuF9P1LJ
 v13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795017046; x=1795621846;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z5NZQpKQ/QY1LZcZkhGbEki1Szvga1AEoVrZ07QVNrA=;
 b=PKfiJzgiPsHYP/vq6mcujaDKO0v2YcMXQ59cf+nLcSuHBfXhPX32ltfSdfAXkPNAkH
 hIn3PPi1ryEHg+ZLFh8FAP41QKyTnjkSqae6xfXtCY80esYepyXL5Y4o21QyZbvpqF7k
 qLrpFPkRT821e1XNZdcRY9BPQtpZdqwKEeZO7upHEvCP+LKJhSz7Y7A1lwCQ4QYj95Kg
 vNeB0zcRg6hKp8X5N4IkkGldAlxeQuRzU2S+aU1Bbq16rcIRJjrixt0BvjrgOa6HHwIB
 aRtGWWQK7Ho8b4kQ+OaBJPZCfUukiUUc/W9ggW+shruTR2um3cuj28DpWkOTrRSQVIMd
 IgPA==
X-Gm-Message-State: APuU4Z8c86meTXJ0cBpIkbHFbA4XNNbUoEqmdcmgFeaaBPvOrJSerBQ+
 ZkO3kkf221mPkK4UTzMICEnwo9q0uYVwgJ6TQVJk1oUx0kyW4ihl9y+yiO9jL6R3VBG1Ij+pYO5
 N61vt1jo/dbv89T6PRG3YA9XL2Oin5BWBmvoxY05OdfLWT1TPEwJgsTAeMkSsUUs/LMKxv9GML+
 YwNa+T2Czg
X-Gm-Gg: AYBFou2jiZPJmuN5TRrcpEf4QjwzaduAfinKW/gdq7O7Zf8dS3lLiUyqj46miQnsXy8
 gRbWQTsTh3KAjn13RS0MDTJkMGO8e5IEtDobeFsCE5wMVrYms5sPhqokb01F9vNlXkdU/I9kopn
 2lxYhaKfxZZJ/5jcUNUxDqA6d5C3IKhbMy9LT4vyuokh59fCQMKVk8pYLeEqyNg9VCQpPlPsQao
 HYBkf7ZyF6uyzyotikQOehzI3L5eqdM3Vc3VoWJQQ9N1iMgkc+bpAw5MMwmY61QaQ6FMgfZ7MMr
 SG9tVpHk1xJEuerkeyej2aPwtdJLQ9Uf2cAzbnVOKT9enYjNriOKQvGdGHJl2Ufv0M8asfAEl9Z
 zSFWrzflfPz5uyLUVXbQ82hc6VvQoMWCZtCxxKAZnl/jWdKfB/0mIfaUV2+6U96wez2nIhd2UsT
 K9CKVzZVL6xZ1jh8VneaflfbWWAdzP343MYRTa6sR5nN0XneXTnmbbbdJTwNeNKm3eWZEZxTsh9
 LjFwEqRnrGpyHUx3ybvJOK87ASt8touVAEh3BmWB5v4tGalUW/vbwKgExJNLa56QugUmy5de8M8
 JKSVtCUERRTNYHLU0BPt9jjZh4szDMRjzIfjulEqMp7221DxnbiVoQ/DZfqDU5SYIlmvgPSK6Z/
 ms/2TyZntimKYbC3m2GE=
X-Received: by 2002:a05:6a00:2296:b0:89e:3ccd:b3c7 with SMTP id
 d2e1a72fcca58-8c5d43f2c1bmr2792134b3a.33.1795010360156; 
 Wed, 18 Nov 2026 05:59:20 -0800 (PST)
Received: from ?IPV6:2001:ee0:4fc2:28e0:e183:b17d:bcb8:a9ff?
 ([2001:ee0:4fc2:28e0:e183:b17d:bcb8:a9ff])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c5cb93cde0sm1275212b3a.51.2026.11.18.05.59.17
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 05:59:18 -0800 (PST)
Message-ID: <b8cd8708-925e-4abc-8c9c-2e397e0e2915@openvpn.com>
Date: Wed, 18 Nov 2026 20:59:15 +0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xThvw-000000002z1-0gTp
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
Content-Type: multipart/mixed; boundary="===============6025429976252097330=="
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--===============6025429976252097330==
Content-Type: multipart/alternative;
 boundary="------------HD0UVJhopgXMaJ1qQY92W9CH"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------HD0UVJhopgXMaJ1qQY92W9CH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 18 November 2026:

  *

    *Updated: donations*
    We now have an official place where people can donate to the OpenVPN
    open source project.
    This is where you can do so;
    https://opencollective.com/openvpn-foss-project
    We will add it to the community wiki and in github so people can
    more readily find it.
    Donations are welcome.

  *

    *New: buildbot server 'pan'*
    Costs are rising for this machine which is hosted currently by
    plaisthos.
    We do have the availability of a backup option which is sponsored by
    OpenVPN Inc. but it's a slower option.
    We will add information that donating hardware may also be an option
    instead of money.
    There is also some seemingly abandoned AWS account for community,
    ordex will look into cleaning that up.

  *

    *New: revising readme.md*
    OpenVPN Inc. asked if we could revise readme.md to add in an
    educative manner the differences between the various openvpn softwares.
    It also seems a good moment to modernize it a lot and add in
    donation details as well.
    The company will arrange for some time to be made available for
    submitting, reviewing, etc. the updated readme.md.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------HD0UVJhopgXMaJ1qQY92W9CH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 18 November 2026:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            donations</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          We now have an official place where people can donate to the
          OpenVPN open source project.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          This is where you can do so; <a
            href="https://opencollective.com/openvpn-foss-project"
style="box-sizing: inherit; background-color: transparent; color: rgb(24, 144, 255); text-decoration: none; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"
            class="moz-txt-link-freetext">https://opencollective.com/openvpn-foss-project</a><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          We will add it to the community wiki and in github so people
          can more readily find it.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Donations are welcome.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">New:
            buildbot server 'pan'</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Costs are rising for this machine which is hosted currently by
          plaisthos.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          We do have the availability of a backup option which is
          sponsored by OpenVPN Inc. but it's a slower option.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          We will add information that donating hardware may also be an
          option instead of money.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          There is also some seemingly abandoned AWS account for
          community, ordex will look into cleaning that up.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">New:
            revising readme.md</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          OpenVPN Inc. asked if we could revise readme.md to add in an
          educative manner the differences between the various openvpn
          softwares.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          It also seems a good moment to modernize it a lot and add in
          donation details as well.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          The company will arrange for some time to be made available
          for submitting, reviewing, etc. the updated readme.md.</p>
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

--------------HD0UVJhopgXMaJ1qQY92W9CH--


--===============6025429976252097330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6025429976252097330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6025429976252097330==--

