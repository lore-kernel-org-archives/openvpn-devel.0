MIME-Version: 1.0
In-Reply-To: <2b6b9f32-ef12-ea5f-ec3b-298f49bba1ec@...1856...>
References: <20170213183826.73008-1-O2Graphics@...2243...>
	<2b6b9f32-ef12-ea5f-ec3b-298f49bba1ec@...1856...>
From: Olivier W <olivierw.ml@...277...>
Date: Wed, 15 Feb 2017 22:34:16 +0100
Message-ID: <CAOAUwZHRLp5+29=ns3_jkEkXVhn9DMbg+hMpvvQF_9X9ekYdYQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix building with LibreSSL 2.5.1 by
 cleaning a hack. Similar to what is done in curl:
 https://github.com/curl/curl/blob/028391df5d84d9fae3433afdee9261d565900355/lib/vtls/openssl.c#L603-L619
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Hello Steffan,

2017-02-14 23:00 GMT+01:00 Steffan Karger <steffan@...1856...>:

> Code still looks good, patch looks a lot better (applies cleanly now),
> but could use an extra newline in the subject.  But that doesn't warrant
> an extra patch iteration, so ACK.

Great, thanks!
Yes, I don't know why my commit has a long line i the subject, when I
used "git commit --amend" to change the message, "Similar to what..."
was on a new line. Next time I'll contribute to OpenVPN, I'll try to
make less mistakes with git.

Best Regards,
Olivier

