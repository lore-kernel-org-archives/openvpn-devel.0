Message-ID: <9e0cf0bf0810191440o51d76ea9mb0c3ebccf5930aa7@...278...>
Date: Sun, 19 Oct 2008 23:40:25 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <27FFC65875B349AFB7648CAA28066833@...576...>
MIME-Version: 1.0
References: <9e0cf0bf0810191327m1904853fx539ecf55419a9d3c@...278...>
	<27FFC65875B349AFB7648CAA28066833@...576...>
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

The CRL that is used is of the CDP of the certificate where the
extension is specified. This also enables the CA to produce several
smaller CRLs, and attach each part to different set of certificates.

You can read [1] for more.

I don't know what you exactly do in your testing. I suggest you
install Microsoft CA, disable the ldap AIA and CDP URLs, and issue
certificates via its interface.

Alon.

[1] http://rfc.net/rfc2459.html#p39

On 10/19/08, Dave <dev@...575...> wrote:
> ...
>
> >
>  > >  *  The CRL is pulled from the CDP in the CA certificate
>  > (i.e. not the
>  > > end  entity certs)
>  >
>  > Not true.
>  > Each certificate is validated against the CRL referred via
>  > its own CDP extension. If there is CDP on root CA it can suicide.
>
> ...
>
>  Certainly not the case in my test.  I created all the end entity certs with
>  the CDP (and AIA) extensions, except the ones that I explicitly removed
>  these for testing.  I also created three versions of the root CA with and
>  without the CDP and AIA.  The combination of:
>
>  *  root CA has no extensions included, client cert has CDP included
>  cause no download of CRL and required an explicitly imported CRL to allow
>  connection.  when swapping out the CA cert for the one that _did_ have the
>  CDP extension, then the CRL was downloaded and the explicitly imported one
>  was not needed.
>
>  Tell me more about 'root CA it can suicide'.  Don't know what you mean.
>
>
>  > You cannot delete this file as it also cached in memory.
>  > In the past I got a program from MS labs to refresh this
>  > cache. At Vista there should be a process/service handling this cache.
>
> ...
>
>  Perhaps it is cached in memory, but I was happily able to delete it and got
>  immediately different results between test cases before and after deletion.
>  I don't know what the scoping of the caching is (system, or process), but
>  for me it was (for practical purposes at least) a file-based cache only.
>
>
>  > >  *  The Crypto API seems to ignore the AIA extension, so no OCSP at
>  > > all,  alas.
>  >
>  > It does not ignore the AIA extension, it downloads the
>  > certificate of the issuer via this extension. For example, if
>  > you have Root->Sub->End
>
>
> Certainly didn't do anything interesting for me.  However I should clarify:
>  when I wrote about AIA, I was also implying that I was using the OCSP OID,
>  and not the URI one.
>
>  ...
>
> > > This would seem to open the
>  > >  door to an 'unrevocation' attack, whereby one installs an old CRL
>
> ...
>
> >
>  > This is standard CRL behavior, it is valid as long as it is
>  > not expired. You can determine this period in the CA
>
> ...
>
>  Maybe, but it sounds like a not-so-great policy:  favoring a CRL this is
>  manually distributed to endpoints over the possibility of checking a
>  centrally-managed online version.  I would set the policy to the reverse.
>  And actually I would more completely set the policy to:
>  *  OCSP via AIA, then
>  *  CRL via CDP, then
>  *  local CRL via capi cache, then
>  *  local CRL stored in capi, then
>  *  --crl-verify, then
>  *  fail open or closed
>  I imagine others might prefer a different ordering or terminal disposition.
>
>  ...
>
> > configuration. If you need instance reaction you need to use OCSP.
>
> ...
>
>  Indeed I do!  Too bad it's not working.
>
>  ...
>
> > You can install OCSP client on your machine and it will be
>  > used automatically. I heard that Vista has this built-in but
>  > never tested.
>
> ...
>
>  sound like you are saying there is an additional component to add to provide
>  OCSP support?  Where to find?  Microsoft?  Have any handy keywords for a web
>  search?
>
>  ...
>
> > You need to look at the end certificates. Go browse to https
>  > site and examine the certificate. You will see AIA for
>  > certificate issued from third level, as there is no actual
>  > need to find the root.
>
> ...
>
>  Sounds plausible, though as mentioned, the end cert CDP did nothing in the
>  testing that I performed.  Only the CDP on the root had an effect on whether
>  the CRL was fetched.
>
>
>  -Dave
>
>

