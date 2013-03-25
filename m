Message-ID: <515019FC.7020703@...1435...>
Date: Mon, 25 Mar 2013 10:33:48 +0100
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
References: <CAHQBeznzF4k-Bx_VSBwAwuy8FYKny3Zcf=6knJwZG8=W4kgVBg@...278...>
In-Reply-To: <CAHQBeznzF4k-Bx_VSBwAwuy8FYKny3Zcf=6knJwZG8=W4kgVBg@...278...>
Subject: Re: [Openvpn-devel] PolarSSL-1.2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

Gert has already covered the first part of your mail, but I too would like to thank you for your efforts.
 

> To the PolarSSL-1.2 support itself: I must confess I didn't test it
> but I believe the new implementation of verify_callback in
> ssl_verify_callback.c is incorrect
> (https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/ssl_verify_polarssl.c#L46).
> It always returns 0. The error is signaled just by setting *flags to
> non-zero value. The flags variable is then reused by PolarSSL for the
> next certificate in the chain. So it might be that the incorrect
> certificate chain won't get accepted but from reading the code it
> seems that non-zero flags coupled with zero return value might result
> in spurious verify error messages for other certificates in the chain.
> Please correct me if I'm wrong.

First of all, we really appreciate everyone who reviews our code and
shares any doubts, so thank you. What you describe is indeed the
behaviour of this code, but I believe this is correct behaviour.

PolarSSL states about the verification callback in x509.h "The function
should return 0 for anything but a fatal error". A fatal error would be
when the function execution fails. When verification itself fails,
errors should be communicated by setting *flags.

Polar does collect errors in *flags while walking through the
certificate chain, but that behaviour is by-design and seems correct to
me. After all, it's the entire chain that fails verification.

-Steffan


