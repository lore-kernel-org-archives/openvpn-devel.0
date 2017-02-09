MIME-Version: 1.0
In-Reply-To: <c3f91fee-f629-fd60-c66c-19d45df6f24f@...1856...>
References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
	<c3f91fee-f629-fd60-c66c-19d45df6f24f@...1856...>
From: Olivier W <olivierw.ml@...277...>
Date: Thu, 9 Feb 2017 18:06:57 +0100
Message-ID: <CAOAUwZFCiksKjxyp9sG7jynRhf8EwRcP77o0zC5crQQz_Cgj4A@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix building with LibreSSL 2.5.1 by
 cleaning a hack.
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

Hello,

2017-02-08 23:39 GMT+01:00 Steffan Karger <steffan@...1856...>:
>
> The code change looks good, and passes my (manual) tests.  I'd like to
> keep the comment though, because this still is a hack/workaround to get
> the private key from the SSL_CTX object, it just does so a little nicer
> at the cost of a number of malloc/free calls.

Thanks for the review!

The hack was because the code was accessing the cert in a strange way,
not using the OpenSSL's functions, that's why I thought it was a good
idea to remove it.
But I'll add it back.

> It might be even worth noting that the workaround is only needed for
> OpenSSL <= 1.0.1, because later versions do have a function to get the
> private key from a struct SSL_CTX directly.  By noting that explicitly,
> we help ourselves remember to get rid of the hack as soon as we drop
> support for these OpenSSL versions.

That's right, I've just looked and like Arne said, we just have to add
a check for OpenSSL >= 1.0.2 and not LibreSSL to use the new function.
I'll update my patch later today.

LibreSSL will probably also add SSL_CTX_get0_privatekey() in a later
version, so the check will be needed to be updated.

Best Regards,
Olivier

