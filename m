From: "Dave" <dev@...575...>
Date: Sun, 19 Oct 2008 16:23:30 -0500
Message-ID: <27FFC65875B349AFB7648CAA28066833@...576...>
MIME-Version: 1.0
In-Reply-To: <9e0cf0bf0810191327m1904853fx539ecf55419a9d3c@...278...>
Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: 'Alon Bar-Lev' <alon.barlev@...277...>
Cc: 'openvpn devel' <openvpn-devel@lists.sourceforge.net>

...
>=20
> >  *  The CRL is pulled from the CDP in the CA certificate=20
> (i.e. not the=20
> > end  entity certs)
>=20
> Not true.
> Each certificate is validated against the CRL referred via=20
> its own CDP extension. If there is CDP on root CA it can suicide.
...

Certainly not the case in my test.  I created all the end entity certs with
the CDP (and AIA) extensions, except the ones that I explicitly removed
these for testing.  I also created three versions of the root CA with and
without the CDP and AIA.  The combination of:

*  root CA has no extensions included, client cert has CDP included
cause no download of CRL and required an explicitly imported CRL to allow
connection.  when swapping out the CA cert for the one that _did_ have the
CDP extension, then the CRL was downloaded and the explicitly imported one
was not needed.

Tell me more about 'root CA it can suicide'.  Don't know what you mean.

> You cannot delete this file as it also cached in memory.
> In the past I got a program from MS labs to refresh this=20
> cache. At Vista there should be a process/service handling this cache.
...

Perhaps it is cached in memory, but I was happily able to delete it and got
immediately different results between test cases before and after deletion.
I don't know what the scoping of the caching is (system, or process), but
for me it was (for practical purposes at least) a file-based cache only.

> >  *  The Crypto API seems to ignore the AIA extension, so no OCSP at=20
> > all,  alas.
>=20
> It does not ignore the AIA extension, it downloads the=20
> certificate of the issuer via this extension. For example, if=20
> you have Root->Sub->End

Certainly didn't do anything interesting for me.  However I should clarify:
when I wrote about AIA, I was also implying that I was using the OCSP OID,
and not the URI one.

...
> > This would seem to open the
> >  door to an 'unrevocation' attack, whereby one installs an old CRL=20
...
>=20
> This is standard CRL behavior, it is valid as long as it is=20
> not expired. You can determine this period in the CA=20
...

Maybe, but it sounds like a not-so-great policy:  favoring a CRL this is
manually distributed to endpoints over the possibility of checking a
centrally-managed online version.  I would set the policy to the reverse.
And actually I would more completely set the policy to:
*  OCSP via AIA, then=20
*  CRL via CDP, then=20
*  local CRL via capi cache, then=20
*  local CRL stored in capi, then
*  --crl-verify, then
*  fail open or closed
I imagine others might prefer a different ordering or terminal disposition.

...
> configuration. If you need instance reaction you need to use OCSP.
...

Indeed I do!  Too bad it's not working.

...
> You can install OCSP client on your machine and it will be=20
> used automatically. I heard that Vista has this built-in but=20
> never tested.
...

sound like you are saying there is an additional component to add to provide
OCSP support?  Where to find?  Microsoft?  Have any handy keywords for a web
search?

...
> You need to look at the end certificates. Go browse to https=20
> site and examine the certificate. You will see AIA for=20
> certificate issued from third level, as there is no actual=20
> need to find the root.
...

Sounds plausible, though as mentioned, the end cert CDP did nothing in the
testing that I performed.  Only the CDP on the root had an effect on whether
the CRL was fetched.

-Dave


