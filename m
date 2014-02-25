Message-ID: <530BE62F.4090709@...1856...>
Date: Tue, 25 Feb 2014 01:39:11 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <5302AADC.80801@...277...>	<20140218085500.GU16637@...1296...>	<530340C4.5060702@...277...>	<20140218115015.GW16637@...1296...>	<5304AFE4.2050702@...277...>	<530917A4.4050905@...1528...>	<53093043.9080808@...277...>	<5309B31C.50208@...1856...>
	<530A9219.8050809@...277...>
In-Reply-To: <530A9219.8050809@...277...>
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

Hi Piotr,

On 24-02-14 01:28, pietrek -- wrote:
> Hi Steffan,
> I modified my patch again. And thanks for your code - it helped me.

Good to hear it helped you. But your new patch basically is my code now,
except that it accepts a configuration without a DH-file.

> 1) In such case server will set ecdh=auto.
> 2)That's a good idea.
> I added initializing both ECDH and DH on server side if they're
> specified in config.

Good.

> 3)It works for me without specifying anything on client side.
> I can also specify different curve for ECDH than used in certificates
> without any errors.

You're completely right, sorry for putting you on this side track.

> I added warning if DH isn't specified - old client may not support ECDH.
> Autodetecting ecdh is a good idea - I made option ecdh=auto.

On the long run I agree that a warning should suffice, but for now I
would really like to stick with forcing the DH-file to be present. Lots
of people using OpenVPN do not understand the crypto or configuration
options properly, but do rely on it for secure communication. As long as
EC-crypto is not common, I prefer to make sure OpenVPN can always fall
back on DH.

> Most of the curves secp, prime, sect work, but some of them ( eg.
> wap-wsg-idm-ecid-wtls10 ) cause ssl error 'no shared cipher'.
> 
> Working curves examples:
> ...
> 
> Failing examples:
> ...

Not all curves supported by OpenSSL are available for use in SSL/TLS,
wap-wsg-idm-ecid-wtls10 sounds like a perfect example of that.
Furthermore, the available curves depend on you version and
configuration of OpenSSL.

One of the things I do not completely grasp yet is why some cipher
suites succeed (e.g. TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA works for me),
but some slightly different ones do not (e.g.
TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA384 and
TLS-ECDH-ECDSA-WITH-AES-256-CBC-SHA do not work for me), even though all
the primitives for those suites are available from the version of
OpenSSL I'm using. Still, the behaviour is different for various OpenSSL
versions. Have you stumbled across this already?

> I also copied from your code option --show-curves, manual entries and EC
> curve autodetection.

Credits for those lines go to Jan Just actually. About the copying,
wouldn't it make more sense if you'd review my implementation, instead
of copying it? The bulk of it is my code now anyway.

Although there is apparently more work to do to get more cipher suites
working, this does give us a start on working with EC-crypto. Maybe this
part can go in (once ACK'ed) as 'the start of EC-support', so more
people can help improve the code. Any other opinions on this?

Regards,
-Steffan

