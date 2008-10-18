Message-ID: <9e0cf0bf0810181101y5fc09e03m7b654a95f29af2fb@...278...>
Date: Sat, 18 Oct 2008 20:01:15 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <CF40BFAE6ED7490E8DA35CF7A9E25F08@...576...>
MIME-Version: 1.0
References: <9e0cf0bf0810141215x7e11d0fcxbc117f7d054d4f03@...278...>
	<CF40BFAE6ED7490E8DA35CF7A9E25F08@...576...>
Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
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
To: Dave <dev@...575...>
Cc: openvpn devel <openvpn-devel@lists.sourceforge.net>

Thank you for testing!

Found the problem... CryptoAPI cannot validate root certificate... OK,
can you please test [1]?

I also renamed the option from cryptoapica to
cryptoapi-chain-validation, I think it is clearer.

Thanks!
Alon.

[1] http://alon.barlev.googlepages.com/openvpn-mscapi-test-5.tar.bz2

On 10/18/08, Dave <dev@...575...> wrote:
> attached herewith is the log of the (failed) attempt(s) to connect.
>
>  Certs are all OK as far as I can tell (no red X overlaid).
>
>  This CA cert I created some years back with easy-RSA.  These days I now
>  manage my CA with XCA off a USB key, but I imported that CA cert rather than
>  rebuilding the PKI.
>
>  Your CRL/OCSP suggestion is interesting, though of course that's Windows
>  only (my servers are all Linux).  Actually I was hoping for an extension of
>  the OCSP patch that was submitted about a year ago, but maybe that is a task
>  for me to do!  Then it would be general across Windows/Linux.  I have not
>  used the extensions before, and I would love it if you had an example cert
>  with the CDP or OCSP extensions filled out so I can use that as a reference
>  to proper form.  My OCSP responder also runs on Linux, rather than Windows.
>
>
>  -Dave
>
>  ...
>
> > Thank you for your tests!
>  >
>  > Your configuration is correct.
>  >
>  > Can you please double click the certificate at the MMC, and
>  > see if it marked "OK"? If there is an error then there is
>  > probably something wrong with CA location or CRL fetch.
>  >
>  > How did you enroll your certificate? If you did this via
>  > microsoft CA, you have CDP (CRL distribution point) X.509
>  > extension that is used by Windows to automatically fetch your
>  > CRL. If you got OCSP responder which is integrated with CAPI
>  > on your machine it will also work in this configuration.
>  >
>  > I added some more debugging information.
>  > Please run the new version [1] with verb 255.
>  > Thanks!
>
> ...
>
>

