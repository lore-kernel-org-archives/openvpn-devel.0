From: "Dave" <dev@...575...>
Date: Sun, 19 Oct 2008 17:41:00 -0500
Message-ID: <4EB32470CE234E889517E73C77B33691@...576...>
MIME-Version: 1.0
In-Reply-To: <9e0cf0bf0810191440o51d76ea9mb0c3ebccf5930aa7@...278...>
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

OK, I recant my comment about the CRL coming from the CA cert in this
implementation -- this was due to an error in my test setup where my peer
cert did _not_ have the CDP as I thought it did when I executed that test,
so placing the correct cert there gave the behaviour you describe.  Thus I
also have to rescind my Verisign hypothesis as well.  I maintain my other
statements, however.

Installing the Microsoft CA is not really an option in my case.  And really,
the whole CRL distribution via the CDP is not either, but rather I was
hoping that OCSP would provide the validation.

-Dave

> -----Original Message-----
> From: Alon Bar-Lev [mailto:alon.barlev@...277...]=20
> Sent: Sunday, October 19, 2008 4:40 PM
> To: Dave
> Cc: openvpn devel
> Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
>=20
>=20
> The CRL that is used is of the CDP of the certificate where=20
> the extension is specified. This also enables the CA to=20
> produce several smaller CRLs, and attach each part to=20
> different set of certificates.
>=20
> You can read [1] for more.
>=20
> I don't know what you exactly do in your testing. I suggest=20
> you install Microsoft CA, disable the ldap AIA and CDP URLs,=20
> and issue certificates via its interface.
>=20
> Alon.
>=20
> [1] http://rfc.net/rfc2459.html#p39
>=20
> On 10/19/08, Dave <dev@...575...> wrote:
> > ...
> >
> > >
> >  > >  *  The CRL is pulled from the CDP in the CA=20
> certificate  > (i.e.=20
> > not the  > > end  entity certs)
> >  >
> >  > Not true.
> >  > Each certificate is validated against the CRL referred via
> >  > its own CDP extension. If there is CDP on root CA it can suicide.
> >
> > ...
> >
> >  Certainly not the case in my test.  I created all the end entity=20
> > certs with  the CDP (and AIA) extensions, except the ones that I=20
> > explicitly removed  these for testing.  I also created=20
> three versions=20
> > of the root CA with and  without the CDP and AIA.  The=20
> combination of:
> >
> >  *  root CA has no extensions included, client cert has CDP=20
> included=20=20
> > cause no download of CRL and required an explicitly imported CRL to=20
> > allow  connection.  when swapping out the CA cert for the one that=20
> > _did_ have the  CDP extension, then the CRL was downloaded and the=20
> > explicitly imported one  was not needed.
> >
> >  Tell me more about 'root CA it can suicide'.  Don't know what you=20
> > mean.
> >
> >
> >  > You cannot delete this file as it also cached in memory.
> >  > In the past I got a program from MS labs to refresh this
> >  > cache. At Vista there should be a process/service handling this=20
> > cache.
> >
> > ...
> >
> >  Perhaps it is cached in memory, but I was happily able to=20
> delete it=20
> > and got  immediately different results between test cases=20
> before and=20
> > after deletion.  I don't know what the scoping of the caching is=20
> > (system, or process), but  for me it was (for practical purposes at=20
> > least) a file-based cache only.
> >
> >
> >  > >  *  The Crypto API seems to ignore the AIA extension,=20
> so no OCSP=20
> > at  > > all,  alas.  >
> >  > It does not ignore the AIA extension, it downloads the
> >  > certificate of the issuer via this extension. For example, if
> >  > you have Root->Sub->End
> >
> >
> > Certainly didn't do anything interesting for me.  However I should=20
> > clarify:  when I wrote about AIA, I was also implying that=20
> I was using=20
> > the OCSP OID,  and not the URI one.
> >
> >  ...
> >
> > > > This would seem to open the
> >  > >  door to an 'unrevocation' attack, whereby one installs an old=20
> > CRL
> >
> > ...
> >
> > >
> >  > This is standard CRL behavior, it is valid as long as it=20
> is  > not=20
> > expired. You can determine this period in the CA
> >
> > ...
> >
> >  Maybe, but it sounds like a not-so-great policy:  favoring=20
> a CRL this=20
> > is  manually distributed to endpoints over the possibility=20
> of checking=20
> > a  centrally-managed online version.  I would set the policy to the=20
> > reverse.  And actually I would more completely set the policy to:
> >  *  OCSP via AIA, then
> >  *  CRL via CDP, then
> >  *  local CRL via capi cache, then
> >  *  local CRL stored in capi, then
> >  *  --crl-verify, then
> >  *  fail open or closed
> >  I imagine others might prefer a different ordering or terminal=20
> > disposition.
> >
> >  ...
> >
> > > configuration. If you need instance reaction you need to use OCSP.
> >
> > ...
> >
> >  Indeed I do!  Too bad it's not working.
> >
> >  ...
> >
> > > You can install OCSP client on your machine and it will be
> >  > used automatically. I heard that Vista has this built-in but  >=20
> > never tested.
> >
> > ...
> >
> >  sound like you are saying there is an additional component=20
> to add to=20
> > provide  OCSP support?  Where to find?  Microsoft?  Have any handy=20
> > keywords for a web  search?
> >
> >  ...
> >
> > > You need to look at the end certificates. Go browse to https
> >  > site and examine the certificate. You will see AIA for
> >  > certificate issued from third level, as there is no=20
> actual  > need=20
> > to find the root.
> >
> > ...
> >
> >  Sounds plausible, though as mentioned, the end cert CDP=20
> did nothing=20
> > in the  testing that I performed.  Only the CDP on the root had an=20
> > effect on whether  the CRL was fetched.
> >
> >
> >  -Dave
> >
> >
>=20
> --------------------------------------------------------------
> -----------
> This SF.Net email is sponsored by the Moblin Your Move=20
> Developer's challenge Build the coolest Linux based=20
> applications with Moblin SDK & win great prizes Grand prize=20
> is a trip for two to an Open Source event anywhere in the=20
> world http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20


