Message-ID: <4FB3CE6A.7090900@...1114...>
Date: Wed, 16 May 2012 17:57:30 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz0V=cE7R=nTefCbP4Z1=+WoYnxhPfNuWasEZjf1EUSOHA@...278...>
	<4FB3810A.4050209@...1114...>
	<CAOazyz11iQ6wuNJ_tp=2U5gH5=jeLkLHL6EG_8+yrDjXtEbFUA@...278...>
	<4FB38570.90902@...1114...>
	<CAOazyz29iYJ2rDPBZzk0Otac543AcYFf_gbHgRgaFo+qcVLpTQ@...278...>
	<4FB39166.9050906@...1114...>
	<CAOazyz2puY6DiXcDKiDy2QaUmHqEtSaTsdgZS6dj=D2RT73mzw@...278...>
	<4FB39E94.1070202@...1114...>
	<CAOazyz3SFQ9Wm070nvvhfn4E0bnpbwsfGc48rnhSMRLwpP_Y9A@...278...>
	<4FB3BA1D.8060608@...1114...>
	<CAOazyz0Y9iH+cvDuU3KzYwqcZKN7ZX+MpyDDCqpKdifzDey1kg@...278...>
In-Reply-To: <CAOazyz0Y9iH+cvDuU3KzYwqcZKN7ZX+MpyDDCqpKdifzDey1kg@...278...>
Subject: Re: [Openvpn-devel] eurephia plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/05/12 16:39, Alon Bar-Lev wrote:
[...snip...]
> 
> I am for announcing the removal have the time for all plugins
> authors which may use this feature to modify their code. There is
> enough time to do so, we are talking about ~5 months.

Just to clarify, as Alon and I have had an IRC discussion today.
We've agreed that we will keep this code snippet enabled by default in
v2.3.  In v2.4 we will flip it to disabled by default.  And in v2.5,
it will go away.

The reason is also that code from James have arrived into the v2.3
code base which provides pretty much the same information as
'tls_digest_%d' does, using a new feature: --x509-track

See commit 9356bae859938c and commit 5cdb5e0111df7b3d for more
information about that.

> I am not sure that anyone knows this one even exists as was unique
> to David's need. So most probably only the eurephia should be
> modified.

I will take care of modifying eurephia and it's documentation.

> Samuli, I think it is simple enough... in the 2.3_alpha2
> announcement, announce that the tls_digest_* environment is
> obsolete and until 2.3 release all plugins authors must modify
> their plugins to use the V3 interface to extract this information
> (if needed).

Plug-ins can use the plug-in API v3 indeed.  Scripts however need to
use the new --x509-track feature instead and be rewritten to extract
the information from a different environment variable.  Both are new
features in the coming OpenVPN v2.3.  So we do need a transition
period before pulling this feature.

So, leave it as is in v2.3, flip to disabled by default in v2.4
(--disable-eurephia changes to --enable-eurephia) and remove it
completely in v2.5.  And add clear and informative release notes for
all of these versions.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+zzmkACgkQDC186MBRfrqBlACggTOMyC8L75Ctpbaxhl3KQ7bu
yCEAnjFI60k7C0In0Bjp98Zo+WipYSlB
=BMvf
-----END PGP SIGNATURE-----

