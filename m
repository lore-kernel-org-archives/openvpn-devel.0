Message-ID: <4F39626D.2080902@...1114...>
Date: Mon, 13 Feb 2012 20:20:13 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <7c22eb11c37c167998cc7975576fe585@...1550...>
	<4F3902E7.3050901@...384...>
	<4F390984.9080503@...1550...> <4F392718.1040603@...1114...>
	<62531c0f691bcbe70d6e942805e271b0@...1550...>
In-Reply-To: <62531c0f691bcbe70d6e942805e271b0@...1550...>
Subject: Re: [Openvpn-devel] [PATCH] Check for ENABLE_MANAGEMENT for
	ENABLE_CLIENT_CR
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
To: igor@...1550...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 13/02/12 18:36, igor@...1550... wrote:
> Thanks!
> 
> Well, i'm no OpenWRT developer, just customizing some packages for my
> needs, but i thought that they are sending patches upstream :)
> 
> Anyway, if i happen to find anything, i'll post here.

Thanks a lot!!!  That's wonderful!  We'll do our best to get these things
into the source tree as soon as possible too :)

> What's for the second patch (gateway/debug stuff), it has been patched
> in OpenWRT too, i just forgot to mention it: 
> https://dev.openwrt.org/browser/packages/net/openvpn-polarssl/patches/400-fix-undefined-print_default.gateway.patch

Ahh,
> 
yeah, I didn't think about checking the other patches.  Even though,
the change in init.c gave me a wtf!? moment ... but it turns out wrapping
that one isn't needed either.  As TEST_GET_DEFAULT_GATEWAY isn't defined
anywhere.  I'm guessing it's James Yonan testing out some code paths
here.  And it's been latent in the code tree for so long I'm wondering if
we need it at all.

And it seems like that there were no more patches in the openwrt tree
even. :)


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk85YmsACgkQDC186MBRfrrVRACfWwJ5OTa9GZ2GP3We0lKYyTNx
MHsAnRVgLjLuenIfDW7whLjWChdMddw/
=QkuB
-----END PGP SIGNATURE-----

