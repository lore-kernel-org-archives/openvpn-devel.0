Message-ID: <9e0cf0bf0809242210x74696837w126ea5caddede127@...278...>
Date: Thu, 25 Sep 2008 08:10:00 +0300
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <750B64C66078B34D918257A1AC004DB205441F@...1132...>
MIME-Version: 1.0
References: <750B64C66078B34D918257A1AC004DB205441F@...1132...>
Subject: Re: [Openvpn-devel] [PATCH v4] Use CryptoAPI CA store (was Re:
	[PATCH v3] Use CryptoAPI CA store)
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
Content-Disposition: inline
To: "Jason R. Coombs" <jaraco@...1130...>
Cc: openvpn-devel@lists.sourceforge.net

Hello,

I cleaned it up a little but still things should be done:

1. Add initialize code and load all entry points for this module at
one place, single LoadLibrary etc...
2. Add cleanup code to unload all static module resources.
3. Check SSL role by OpenSSL configuration (client or server), see
TODO signature.
4. Cleanup warnings.

Available at [1], I did not check it as I don't have active Windows
configuration now.
Can you please complete it?

Alon.

[1] http://svn.openvpn.net/projects/openvpn/contrib/alon/BETA21-ms-chk-2/openvpn

On 9/24/08, Jason R. Coombs <jaraco@...1130...> wrote:
> I'd really like to see this feature in a future build.
>
>  Is there anything more that needs to be done to integrate this into 2.1?
>  I can help with code cleanup/refactoring.  I don't have a development
>  environment set up, though, so I'd be working blind.
>
>  Cheers,
>  Jason
>
>  On 9/23/07, Faidon Liambotis Wrote:
>  Alon Bar-Lev wrote:
>  > On 9/22/07, Faidon Liambotis <paravoid@...1131...> wrote:
>  >> Alon Bar-Lev wrote:
>  >>> So you need to use CertVerifyCertificateChainPolicy() with
>  CERT_CHAIN_POLICY_SSL
>  >> I'm no Microsoft developer (adn I don't want to be to be honest) but
>  if
>  >> I understand it right, it's better to call CertGetCertificateChain()
>  as
>  >> I am doing.
>  >
>  > You need to use both, one for create the chain and the other to verify
>  > that it meets with system CTL for SSL.
>  Seems that you are right. Below you will find -v4 of the patch that does
>  that.
>
>  Also, my previous version didn't actually check for revocations,
>  contrary to what I documented.
>  I added CERT_CHAIN_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT to the dwFlags of
>  CertGetCertificateChain.
>
>  Let me know what you think.
>
>  Thanks,
>  Faidon
>
>
>  -------------------------------------------------------------------------
>  This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
>  Build the coolest Linux based applications with Moblin SDK & win great prizes
>  Grand prize is a trip for two to an Open Source event anywhere in the world
>  http://moblin-contest.org/redirect.php?banner_id=100&url=/
>  _______________________________________________
>  Openvpn-devel mailing list
>  Openvpn-devel@lists.sourceforge.net
>  https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

