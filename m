MIME-Version: 1.0
In-Reply-To: <201702160747.v1G7l61Y058076@...2054...>
References: <20170213183826.73008-1-O2Graphics@...2243...>
	<201702160747.v1G7l61Y058076@...2054...>
From: Olivier W <olivierw.ml@...277...>
Date: Sat, 18 Feb 2017 02:37:30 +0100
Message-ID: <CAOAUwZHZGVh+zWZJg8+JT6FzqhokyuaXT6YGiDHLtvu99SFCFg@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix building with LibreSSL
 2.5.1 by cleaning a hack. Similar to what is done in curl:
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hello Gert,

2017-02-16 8:47 GMT+01:00 Gert Doering <gert@...1296...>:
> Your patch has been applied to the master and release/2.4 branch.
>
> Not sure if it is something we want in release/2.3, but it wouldn't apply
> with "git cherry-pick" - too much formatting changes, so one would need
> to do it manually ("but we knew this").

I just had a quick look at release/2.3 and the code I patched (around
the SSL_get_privatekey() call) isn't present at all. So there's no
need for a patch there.

Best Regards,
Olivier

