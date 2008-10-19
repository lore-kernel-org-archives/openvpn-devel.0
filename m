From: "Dave" <dev@...575...>
Date: Sun, 19 Oct 2008 15:10:24 -0500
Message-ID: <BAB5AEF34D2B404FBEBE3DA8743BD603@...576...>
MIME-Version: 1.0
In-Reply-To: <465730FFADD349CF845F2B0CE8CA37D0@...576...>
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

OK, I built a new PKI and issued certs with both the CDP and/or/neither AIA
extensions.  Here are some observations for any interested:

*  The Crypto API will pick up the CRL automatically from the URI in the CDP
extension, if present.
*  If it cannot be retrieved, validation fails.
*  The CRL is pulled from the CDP in the CA certificate (i.e. not the end
entity certs)
*  The Crypto API caches this CRL for a period of time unknown to me.  For
those interested the cache locations is (approximately):
    E:\Documents and Settings\{username}\Application
Data\Microsoft\CryptnetUrlCache\Content
   (you'll have to substitute you user name and root drive letter in that
path).  You'll have to read into the content to find which file, but if you
sort by date, then that might make things easier if it is freshly
downloaded.  Deleting this file seems to have no consequences other than
causing it to be re-downloaded.
*  The Crypto API seems to ignore the AIA extension, so no OCSP at all,
alas.


Some fun observations:

*  The Crypto API will ignore the CDP-fetched or even cached CRL if there is
an explicit one imported into the capi store.  This would seem to open the
door to an 'unrevocation' attack, whereby one installs an old CRL that does
not contain certs revoked after it's creation, and thus those certs become
trusted again irrespective of their being in a currently distributed CRL
(via the CDP), or even a cached CRL that was downloaded prior to the
installation of the rogue CRL.


Some other observations:

*  _none_ of the Verisign CA certs installed on my XPSP3 machine have either
the CDP or AIA extension specified.  So I assume this would imply that if I
ran a server using a Verisign-issued cert, then it would never succeed to
validate client-side using the --cryptoapi-chain-validation option since I
do not have a CRL for that CA, nor is there a CDP extension specified in
it's root cert.  I don't' have the spare change to order a server cert from
Verisign for testing this hypothesis.


A tip for those wanting to use the --cryptoapi-chain-validation option, but
having an existing PKI and not wishing to completely rebuild it:

*  You can effectively re-issue your CA cert with the CDP option added (so
you don't have to rebuild the whole PKI) if you do the following:
     *  use the exact same DN
     *  use the same 'not before' time stamp
     *  use a 'not after' timestamp later than the original
     *  use the same private key
     *  change whatever other option you like -- key usage, CDP, AIA, etc.
   if you do this, then all the certs signed with the original CA cert will
still be valid with respect to the newly created (and modified) CA cert.

-Dave


> -----Original Message-----
> From: Dave [mailto:dev@...575...]=20
> Sent: Saturday, October 18, 2008 6:08 PM
> To: 'Alon Bar-Lev'
> Cc: 'openvpn devel'
> Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
>=20
>=20
> Gotcha.  I'm still sceptical but I certainly have been wrong=20
> before -- I'll double check my assumptions.
>=20
> Regarding VMWare, if you are able to install Windows in a=20
> compliant way at present, then presumably you could just as=20
> easily install in in VMWare and be in license compliance.  On=20
> the other hand, you need the VMWare license to create a new=20
> VM (though you can run an existing created VM for free,=20
> though, with player).
>=20
> > -----Original Message-----
> > From: Alon Bar-Lev [mailto:alon.barlev@...277...]
> > Sent: Saturday, October 18, 2008 4:48 PM
> > To: Dave
> > Cc: openvpn devel
> > Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
> >=20
> >=20
> > Hello,
> >=20
> > Microsoft complete the chain using CDP extension. This
> > extension contains the URL from which to fetch the CRL. So=20
> > you don't need to distribute the CRL by your self, you only=20
> > need to put this on accessible HTTP server. If you don't have=20
> > CDP you won't be able to work well within Microsoft domain.
> >=20
> > If you look at the CryptoAPI you will see that you cannot
> > determine if you have or don't have CRL in store. What you=20
> > request is not standard in Windows environment.
> >=20
> > Regarding VMWare and such... there is also a matter of
> > licensing, tools and time required... I thank you for=20
> > testing, I would have done so if the 7th round failed.
> >=20
> > Alon.
> >=20
> > On 10/18/08, Dave <dev@...575...> wrote:
> > > I would tend to disagree.  The only CRLs in my store are the one I
> > > added,  and an ancient Verisign one containing three=20
> infamous bogus=20
> > > Microsoft certs  they erroneously issued from 8 or so years=20
> > ago.  If
> > > the CRL (even an empty
> > >  one) were indeed required, then pretty much all certs I
> > have ever been
> > >  presented that were not Verisign would fail, no?
> > >
> > >  I recognize the merits of requiring a CRL be installed,
> > even empty,
> > > as a  matter of personal administrative policy.  I for one however
> > > don't intend to  distribute and install updated CRLs to all=20
> > my clients
> > > and servers upon each  change (hence my interest in the CDP and,
> > > preferably, OCSP, mechanisms).  I  would much rather the=20
> > absence of a
> > > CRL in CAPI to be treated as 'success'  and rely on another
> > > (centralized) mechanism to provide validation.
> > >
> > >  I forgot to mention in my previous email:  why don't you set up a
> > > VMWare  image for your Windows build/test environment.=20=20
> > This is what I
> > > do for my  five-or-so different build environments.
> > >
> > >
> > >  -Dave
> > >
> > >  > -----Original Message-----
> > >  > From: Alon Bar-Lev [mailto:alon.barlev@...277...]
> > >
> > > > Sent: Saturday, October 18, 2008 4:19 PM
> > >  > To: Dave
> > >  > Cc: openvpn devel
> > >  > Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
> > >  >
> > >  >
> > >  > I think that missing CRL should fail. This is how MS is  >=20
> > > working. There is no point in PKI without CRL... If you
> > want  > to
> > > do something other you can use the CTL feature of CAPI.=20=20
> >  > Thanks=20
> > > for testing!!!  > Alon.
> > >  >
> > >  > On 10/18/08, Dave <dev@...575...> wrote:
> > >  > > OK better but not perfect:
> > >  > >
> > >  > >  1)  missing CA in trusted roots:  fails to verify; good
> > >  > >  2)  missing CRL:  FAILS TO VERIFY; BAD
> > >  > >  3)  CRL with revoked cert:  fails to verify, good
> > >  > >  3.bis)  CRL _without_ revoked cert:  verifies, good
> > >  > >
> > >  > >  so it seems the coup-de-grace would be to make the absence
> > >  > of the CRL
> > >  > > act  like nothing is revoked, or add some=20
> > options/parameters, maybe
> > >  > > like:
> > >  > >
> > >  > >     cryptoapi-chain-validation require-crl-present
> > >  > >
> > >  > >  I'd still like to see an example of a well-formed=20
> value  > for=20
> > > CDP, and  > > Authority Info Access extension so I can=20
> re-issue my=20
> > > CA  > cert and test
> > >  > > the  hypothetical CAPI built-in OCSP/CRL checking....
> > >  > >
> > >  > >
> > >  > >  -Dave
> > >  > >
> > >  > >  > -----Original Message-----
> > >  > >  > From: Alon Bar-Lev [mailto:alon.barlev@...277...]
> > >  > >
> > >  > > > Sent: Saturday, October 18, 2008 3:29 PM
> > >  > >  > To: Dave
> > >  > >  > Cc: openvpn devel
> > >  > >  > Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
> > >  > >  >
> > >  > >  >
> > >  > >  > Oh!
> > >  > >  > Thanks!!!!
> > >  > >  > I feared I had to install Windows again :)
> > >  > >  >
> > >  > >  > So now everything should be fine... you should be able
> > >  > to  > check
> > >  > > the chain validation... 1. Without trusted CA in store.  >
> > >  > 2. Without
> > >  > > CRL in store. 3. With CRL but with certificate revoked.  >
> > >  > >  > Alon.
> > >  > >  >
> > >  > >  > On 10/18/08, Dave <dev@...575...> wrote:
> > >  > >  > > Sorry, I lied.  Success!  I somehow failed to copy the
> > >  > openvpn.exe
> > >  > >  > > over.  Attached herewith is the log.
> > >  > >  > >
> > >  > >  > >
> > >  > >  > >
> > >  > >  > >  > -----Original Message-----
> > >  > >  > >  > From: Dave [mailto:dev@...575...]
> > >  > >  > >  > Sent: Saturday, October 18, 2008 3:19 PM
> > >  > >  > >  > To: 'Alon Bar-Lev'
> > >  > >  > >  > Cc: 'openvpn devel'
> > >  > >  > >  > Subject: RE: [Openvpn-devel] [MSCAPI] Need testers
> > >  > >  > >  >
> > >  > >  > >  >
> > >  > >  > >  > Alas, the same.
> > >  > >  > >  >
> > >  > >  > >  > > -----Original Message-----
> > >  > >  > >  > > From: Alon Bar-Lev [mailto:alon.barlev@...277...]
> > >  > >  > >  > > Sent: Saturday, October 18, 2008 2:31 PM
> > >  > >  > >  > > To: Dave
> > >  > >  > >  > > Cc: openvpn devel
> > >  > >  > >  > > Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
> > >  > >  > >  > >
> > >  > >  > >  > >
> > >  > >  > >  > > Thank you for your time!
> > >  > >  > >  > > Last time... If we don't make any progress I will
> > >  > install  > >
> > >  > >  > > Windows setup when I have some free time. The problem is
> > >  > >  > may  > > be
> > >  > >  > > due to RSA_FLAG_SIGN_VER flag that should be=20
> set on the  >
> > >  > >  > > RSA and
> > >  > >  > > not the method. Can you please test [1]?  > >
> > >  > >  > >  > > Alon.
> > >  > >  > >  > >
> > >  > >  > >  > > [1]
> > >  > >  >=20
> > http://alon.barlev.googlepages.com/openvpn-mscapi-test-7.tar.bz2
> > >  > >  > >  > >
> > >  > >  > >  > > On 10/18/08, Dave <dev@...575...>=20
> wrote:  > >  >=20
> > > >  > > > Nope, still crashes.  > >  > >  > > >
> > >  > >  > >  > > >  Application Event Log reveals:
> > >  > >  > >  > > >
> > >  > >  > >  > > >   Faulting application openvpn.exe,=20
> > version 0.0.0.0,
> > >  > >  > >  > > faulting module
> > >  > >  > >  > > > libeay32.dll, version 0.9.9.0, fault
> > address 0x0005c4c5.
> > >  > >  > >  > > >
> > >  > >  > >  > > >  I suppose there's no debug info in the
> > MinGW build -- I
> > >  > >  > >  > > can attach a
> > >  > >  > >  > > > debugger when it crashes and could see the  >=20
> > > source if there  > >  > >  > > was debug
> > >  > >  > >  > > > info.  Invariably something about my=20
> > config triggers
> > >  > >  > some boundary
> > >  > >  > >  > > > case.
> > >  > >  > >  > > >
> > >  > >  > >  > > >  When testing only with cryptoapicert, the  >=20
> > > failure occurs  > >  > >  > > also, and is
> > >  > >  > >  > > > logged  as having had happened at the same=20
> > location.
> > >  > >  > >  > > >
> > >  > >  > >  > > >
> > >  > >  > >  > > >  -Dave
> > >  > >  > >  > > >
> > >  > >  > >  > > >  > -----Original Message-----
> > >  > >  > >  > > >  > From: Alon Bar-Lev
> > [mailto:alon.barlev@...277...]
> > >  > >  > >  > > >
> > >  > >  > >  > > > > Sent: Saturday, October 18, 2008 1:51=20
> PM  > >  >=20
> > > >  > > >  > To: Dave  > >  > >  > > >  > Cc: openvpn devel
> > >  > >  > >  > > >  > Subject: Re: [Openvpn-devel] [MSCAPI]=20
> > Need testers
> > >  > >  > >  > > >  >
> > >  > >  > >  > > >  >
> > >  > >  > >  > > >  > I cannot see what is wrong, what exactly  >=20
> > > crashes? Do you  > >  > >  > > have  > an
> > >  > >  > >  > > > entry in event log?, I recompiled=20
> > everything at [1], I
> > >  > >  > >  > may  > had a
> > >  > >  > >  > > > problem with the libraries. Can you=20
> please test  >=20
> > > only  > with  > >  > >  > > > cryptoapicert and see if it changes=20
> > > something?  >  > >  > >  > > >  > Thanks!
> > >  > >  > >  > > >  >
> > >  > >  > >  > > >  > [1]
> > >  > >  > >  > >
> > >  > >  >=20
> > http://alon.barlev.googlepages.com/openvpn-mscapi-test-6.tar.bz2
> > >  > >  > >  > > >  >
> > >  > >  > >  > > >  > On 10/18/08, Dave=20
> <dev@...575...> wrote:  >=20
> > > >  > >  > > >  > > A little bit further, though now it
> > crashes for me
> > >  > >  > >  > > using all the
> > >  > >  > >  > > >  > > binaries  you included in your bz=20
> file.  > Log=20
> > > attached  >  > >  > >  > > > herewith in case  > > that helps=20=20
> > > locate the  > area affected.
> > >  > >  > >  > > >  > >
> > >  > >  > >  > > >  > >
> > >  > >  > >  > > >  > >  -Dave
> > >  > >  > >  > > >  > >
> > >  > >  > >  > > >  > >  > -----Original Message-----
> > >  > >  > >  > > >  > >  > From: Alon Bar-Lev
> > >  > [mailto:alon.barlev@...277...]
> > >  > >  > >  > > >  > >
> > >  > >  > >  > > >  > > > Sent: Saturday, October 18, 2008 1:01 PM
> > >  > >  > >  > > >  > >  > To: Dave
> > >  > >  > >  > > >  > >  > Cc: openvpn devel
> > >  > >  > >  > > >  > >
> > >  > >  > >  > > >  > > > Subject: Re: [Openvpn-devel] [MSCAPI]
> > >  > Need testers
> > >  > >  > >  > > >  > >  >
> > >  > >  > >  > > >  > >  >
> > >  > >  > >  > > >  > >
> > >  > >  > >  > > >  > > > Thank you for testing!
> > >  > >  > >  > > >  > >  >
> > >  > >  > >  > > >  > >  > Found the problem... CryptoAPI cannot
> > >  > validate root
> > >  > >  > >  > > >  > >  > certificate... OK, can you=20
> please test [1]?
> > >  > >  > >  > > >  > >  >
> > >  > >  > >  > > >  > >  > I also renamed the option from=20
> > cryptoapica to
> > >  > >  > >  > > >  > >  > cryptoapi-chain-validation, I=20
> think it  >=20
> > > is clearer.  > >  > >  > > >  > >  >
> > >  > >  > >  > > >  > >  > Thanks!
> > >  > >  > >  > > >  > >  > Alon.
> > >  > >  > >  > > >  > >  >
> > >  > >  > >  > > >  > >  > [1]
> > >  > >  > >  > > >  > >
> > >  > >  > >  > >
> > >  > >  >=20
> > http://alon.barlev.googlepages.com/openvpn-mscapi-test-5.tar.bz2
> > >  > >  > >  > > >  > >  >
> > >  > >  > >  > > >  > >  > On 10/18/08, Dave
> > <dev@...575...> wrote:
> > >  > >  > >  > > >  > >  > > attached herewith is the log of
> > the (failed)
> > >  > >  > >  > > >  > attempt(s) to connect.
> > >  > >  > >  > > >  > >  > >
> > >  > >  > >  > > >  > >  > >  Certs are all OK as far as I=20
> can  > tell=20
> > > (no red X  > >  > >  > > overlaid).
> > >  > >  > >  > > >  > >  > >
> > >  > >  > >  > > >  > >  > >  This CA cert I created some=20
> > years back with
> > >  > >  > >  > easy-RSA.  >
> > >  > >  > >  > > > >  > These days I  > >  > > now  manage=20
> my CA with=20=20
> > > > >  > XCA off a USB  > >  > >  > > > key, but I imported  > >  >=20
> > > that CA cert  > >  > >  > > >  > >  > > rather than=20=20
> rebuilding the=20
> > > PKI.  > >  > >  > > >  > >  > >
> > >  > >  > >  > > >  > >  > >  Your CRL/OCSP suggestion is
> > >  > interesting, though of
> > >  > >  > >  > > >  > course that's
> > >  > >  > >  > > >  > >  > > Windows  only (my servers are=20
> all Linux).
> > >  > >  > >  > Actually I was
> > >  > >  > >  > > >  > >  > hoping for
> > >  > >  > >  > > >  > >  > > an extension of  the OCSP=20
> patch that was
> > >  > >  > >  > submitted about a
> > >  > >  > >  > > >  > >  > year ago,
> > >  > >  > >  > > >  > >  > > but maybe that is a task  for me to do!
> > >  > >  > Then it would
> > >  > >  > >  > > >  > be general
> > >  > >  > >  > > >  > >  > > across Windows/Linux.  I have not  used
> > >  > >  > the extensions
> > >  > >  > >  > > >  > >  > before, and I
> > >  > >  > >  > > >  > >  > > would love it if you had an=20
> > example cert  with
> > >  > >  > >  > > the CDP or OCSP
> > >  > >  > >  > > >  > >  > > extensions filled out so I can
> > use that as a
> > >  > >  > >  > reference  >
> > >  > >  > >  > > > to proper  > >  > > form.  My OCSP=20
> responder also=20=20
> > > > >  > runs on Linux,  > >  > >  > > > rather  > than Windows.
> > >  > >  > >  > > >  > >  > >
> > >  > >  > >  > > >  > >  > >
> > >  > >  > >  > > >  > >  > >  -Dave
> > >  > >  > >  > > >  > >  > >
> > >  > >  > >  > > >  > >  > >  ...
> > >  > >  > >  > > >  > >  > >
> > >  > >  > >  > > >  > >  > > > Thank you for your tests!
> > >  > >  > >  > > >  > >  > >  >
> > >  > >  > >  > > >  > >  > >  > Your configuration is correct.
> > >  > >  > >  > > >  > >  > >  >
> > >  > >  > >  > > >  > >  > >  > Can you please double click=20
> > the certificate
> > >  > >  > >  > at the MMC,
> > >  > >  > >  > > >  > >  > and  > see
> > >  > >  > >  > > >  > >  > > if it marked "OK"? If there is=20
> an error=20=20
> > > > >  > then there is  > >  > >  > > >  > > probably
> > >  > >  > >  > > >  > >  > > something wrong with CA location or
> > >  > CRL fetch.  >
> > >  > >  > >  > > >  > >  > >  > How did you enroll your=20
> > certificate? If you
> > >  > >  > >  > > did this via
> > >  > >  > >  > > >  > >  > >  > microsoft CA, you have CDP (CRL  >=20
> > > distribution  > >  > >  > > point) X.509
> > >  > >  > >  > > >  > >  > >  > extension that is used by Windows to
> > >  > >  > >  > automatically  >
> > >  > >  > >  > > > fetch your  > >  > >  > CRL. If you got OCSP
> > >  > >  > responder which is
> > >  > >  > >  > > integrated with CAPI
> > >  > >  > >  > > >  > >  > >  > on your machine it will also=20
> > work in this
> > >  > >  > >  > > configuration.
> > >  > >  > >  > > >  > >  > >  >
> > >  > >  > >  > > >  > >  > >  > I added some more debugging
> > information.
> > >  > >  > >  > > >  > >  > >  > Please run the new version
> > [1] with verb
> > >  > >  > >  > 255.  > >  > >
> > >  > >  > >  > > > > Thanks!  > >  > >
> > >  > >  > >  > > >  > >  > > ...
> > >  > >  > >  > > >  > >  > >
> > >  > >  > >  > > >  > >  > >
> > >  > >  > >  > > >  > >  >
> > >  > >  > >  > > >  > >
> > >  > >  > >  > > >  > > >
> > >  > >  > >  > >
> > >  > --------------------------------------------------------------
> > >  > >  > >  > > >  > >  > -----------
> > >  > >  > >  > > >  > >  > This SF.Net email is sponsored by the  >=20
> > > Moblin Your  > >  > >  > Move  > >
> > >  > >  > >  > > > > Developer's challenge Build the coolest Linux
> > >  > based  > >  >
> > >  > >  > >  > > > applications with Moblin SDK & win great=20
> > prizes Grand  >
> > >  > >  > >  > prize  > is
> > >  > >  > >  > > > a  > > trip for two to an Open Source
> > event anywhere in
> > >  > >  > >  > the  > world
> > >  > >  > >  > > >  > >
> > >  > >  > http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
> > >  > >  > >  > > >  > >  >
> > _______________________________________________
> > >  > >  > >  > > >  > >  > Openvpn-devel mailing list
> > >  > >  > >  > > >  > >  > Openvpn-devel@lists.sourceforge.net
> > >  > >  > >  > > >  > >  >
> > >  > >  > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> > >  > >  > >  > > >  > >  >
> > >  > >  > >  > > >  > >
> > >  > >  > >  > > >  > >
> > >  > >  > >  > > >  >
> > >  > >  > >  > > >  >
> > >  > >  >
> > --------------------------------------------------------------
> > >  > >  > >  > > >  > -----------
> > >  > >  > >  > > >  > This SF.Net email is sponsored by the=20
> Moblin  >=20
> > > Your Move  > >  > >  > > >  > Developer's challenge Build the=20
> > > coolest
> > Linux based
> > >  > >  > >  > > >  > applications with Moblin SDK & win=20
> great prizes=20=20
> > > > >  > Grand prize  > >  > >  > > >  > is a trip for two=20
> to an Open=20
> > > Source event  > anywhere in the
> > >  > >  > >  > > >  > world
> > >  > >  > >  >=20
> > http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
> > >  > >  > >  > > >  >=20
> _______________________________________________
> > >  > >  > >  > > >  > Openvpn-devel mailing list
> > >  > >  > >  > > >  > Openvpn-devel@lists.sourceforge.net
> > >  > >  > >  > > >  >
> > >  > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> > >  > >  > >  > > >  >
> > >  > >  > >  > > >
> > >  > >  > >  > > >
> > >  > >  > >  > >
> > >  > >  > >  > >
> > >  > --------------------------------------------------------------
> > >  > >  > >  > > -----------
> > >  > >  > >  > > This SF.Net email is sponsored by the Moblin
> > Your Move
> > >  > >  > >  > > Developer's challenge Build the coolest=20
> Linux based=20=20
> > > > >  > >  > > applications with Moblin SDK & win great prizes  >=20
> > > Grand prize  > >  > >  > > is a trip for two to an Open=20
> Source event
> > anywhere in the
> > >  > >  > >  > > world
> > >  > >  > http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
> > >  > >  > >  > > _______________________________________________
> > >  > >  > >  > > Openvpn-devel mailing list
> > >  > >  > >  > > Openvpn-devel@lists.sourceforge.net
> > >  > >  > >  > >
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> > >  > >  > >  > >
> > >  > >  > >  >
> > >  > >  > >
> > >  > >  > >
> > >  > >  >
> > >  > >
> > >  > >
> > >  >
> > >  > --------------------------------------------------------------
> > >  > -----------
> > >  > This SF.Net email is sponsored by the Moblin Your Move
> > >  > Developer's challenge Build the coolest Linux based
> > >  > applications with Moblin SDK & win great prizes Grand=20
> prize  > is=20
> > > a trip for two to an Open Source event anywhere in the  > world=20
> > > http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
> > >  > _______________________________________________
> > >  > Openvpn-devel mailing list
> > >  > Openvpn-devel@lists.sourceforge.net
> > >  > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> > >  >
> > >
> > >
> >=20
> > --------------------------------------------------------------
> > -----------
> > This SF.Net email is sponsored by the Moblin Your Move
> > Developer's challenge Build the coolest Linux based=20
> > applications with Moblin SDK & win great prizes Grand prize=20
> > is a trip for two to an Open Source event anywhere in the=20
> > world http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >=20
>=20
>=20
> --------------------------------------------------------------
> -----------
> This SF.Net email is sponsored by the Moblin Your Move=20
> Developer's challenge
> Build the coolest Linux based applications with Moblin SDK &=20
> win great prizes
> Grand prize is a trip for two to an Open Source event=20
> anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20


