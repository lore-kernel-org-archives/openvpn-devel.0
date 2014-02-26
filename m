Message-ID: <530E5529.9080204@...1856...>
Date: Wed, 26 Feb 2014 21:57:13 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <5302AADC.80801@...277...>	<20140218085500.GU16637@...1296...>	<530340C4.5060702@...277...>	<20140218115015.GW16637@...1296...>	<5304AFE4.2050702@...277...>	<530917A4.4050905@...1528...>	<53093043.9080808@...277...>	<5309B31C.50208@...1856...>	<530A9219.8050809@...277...>	<530BE62F.4090709@...1856...>
	<530E48C2.5090209@...277...>
In-Reply-To: <530E48C2.5090209@...277...>
Subject: Re: [Openvpn-devel] [Patch] ECDH support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 26-02-14 21:04, pietrek -- wrote:
> I tested what would happen if any key exchange protocol will be specified.
> It works as I expected: connection failed with error: 'no such cipher'.
> So session cannot work without ECDH and DH.
> Also, if OpenSSL would accept it, it would be an invitatation for men in 
> the middle ;)
>
> For clients without ECDH connection will just fail.

Interesting, with the current setup and OpenSSL behaviour (at least up
to OpenSSL 1.0.1) you are right. Since commit 813aa55 (last January),
where ephemeral RSA support was dropped, OpenVPN knows no other way for
key exchange but DH (and ECDH after the updates). Without that, OpenVPN
would fall back to RSA for key exchange, which is not directly
vulnerable to man-in-the-middle attacks, but it would mean falling back
to less secure cipher suites.

However, we completely depend on OpenSSL being incapable of doing some
sort of key exchange automatically, which I think is a bit risky. If we
can make absolutely sure OpenSSL will not fall back, we might be able to
remove the requirement for the DH-file from a security perspective.

> In my opinion forcing users to specify DH key isn no longer neccessary, 
> because this file generates
> long and protection against men in the middle attack is as strong as the 
> weakest encryption algorithm
> so if DH will be weaker than ECDH curve, even the best curve won't 
> improve security against such attack.

OpenSSL prefers ECDH over DH, so if both client and server support it,
the connection would not use DH. A user who does not trust DH anymore
could specifiy something like --tls-cipher DEFAULT:\!DH:\!EXP to
explicitly forbid usage of DH.

I agree that the DH-file generation is not one of OpenVPN's most
user-friendly features, but a server administrator has to it just once
and clients are not bothered by it at all.

Furthermore, I expect that if we would make it 'too easy' to create
ECDH-only servers many people would run into trouble when one of their
peers has an older version of OpenVPN (of which there are a *lot*) and
gets the "no shared cipher" error. An administrator diving into the
crypto, specifying explicitly to not trust DH should be able to cope
with that, but new users probably do not.

To conclude, I agree with you that the restriction on the DH-file should
eventually disappear, I just think right now is a bit premature.

-Steffan

