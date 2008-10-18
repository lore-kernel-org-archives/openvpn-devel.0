From: "Dave" <dev@...575...>
Date: Sat, 18 Oct 2008 14:15:05 -0500
Message-ID: <6C08722C53E64CF1992DA65D30C553A1@...576...>
MIME-Version: 1.0
In-Reply-To: <9e0cf0bf0810181151p75931b8fl53f8babd938e9d3f@...278...>
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

Nope, still crashes.

Application Event Log reveals:

  Faulting application openvpn.exe, version 0.0.0.0, faulting module
libeay32.dll, version 0.9.9.0, fault address 0x0005c4c5.

I suppose there's no debug info in the MinGW build -- I can attach a
debugger when it crashes and could see the source if there was debug info.
Invariably something about my config triggers some boundary case.

When testing only with cryptoapicert, the failure occurs also, and is logged
as having had happened at the same location.

-Dave

> -----Original Message-----
> From: Alon Bar-Lev [mailto:alon.barlev@...277...]=20
> Sent: Saturday, October 18, 2008 1:51 PM
> To: Dave
> Cc: openvpn devel
> Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
>=20
>=20
> I cannot see what is wrong, what exactly crashes? Do you have=20
> an entry in event log?, I recompiled everything at [1], I may=20
> had a problem with the libraries. Can you please test only=20
> with cryptoapicert and see if it changes something?
>=20
> Thanks!
>=20
> [1] http://alon.barlev.googlepages.com/openvpn-mscapi-test-6.tar.bz2
>=20
> On 10/18/08, Dave <dev@...575...> wrote:
> > A little bit further, though now it crashes for me using all the=20
> > binaries  you included in your bz file.  Log attached=20
> herewith in case=20
> > that helps  locate the area affected.
> >
> >
> >  -Dave
> >
> >  > -----Original Message-----
> >  > From: Alon Bar-Lev [mailto:alon.barlev@...277...]
> >
> > > Sent: Saturday, October 18, 2008 1:01 PM
> >  > To: Dave
> >  > Cc: openvpn devel
> >
> > > Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
> >  >
> >  >
> >
> > > Thank you for testing!
> >  >
> >  > Found the problem... CryptoAPI cannot validate root
> >  > certificate... OK, can you please test [1]?
> >  >
> >  > I also renamed the option from cryptoapica to
> >  > cryptoapi-chain-validation, I think it is clearer.
> >  >
> >  > Thanks!
> >  > Alon.
> >  >
> >  > [1]=20
> > http://alon.barlev.googlepages.com/openvpn-mscapi-test-5.tar.bz2
> >  >
> >  > On 10/18/08, Dave <dev@...575...> wrote:
> >  > > attached herewith is the log of the (failed)=20
> attempt(s) to connect.
> >  > >
> >  > >  Certs are all OK as far as I can tell (no red X overlaid).
> >  > >
> >  > >  This CA cert I created some years back with easy-RSA.
> >  > These days I
> >  > > now  manage my CA with XCA off a USB key, but I imported
> >  > that CA cert
> >  > > rather than  rebuilding the PKI.
> >  > >
> >  > >  Your CRL/OCSP suggestion is interesting, though of=20
> course that's
> >  > > Windows  only (my servers are all Linux).  Actually I was
> >  > hoping for
> >  > > an extension of  the OCSP patch that was submitted about a
> >  > year ago,
> >  > > but maybe that is a task  for me to do!  Then it would=20
> be general
> >  > > across Windows/Linux.  I have not  used the extensions
> >  > before, and I
> >  > > would love it if you had an example cert  with the CDP or OCSP
> >  > > extensions filled out so I can use that as a reference=20
>  to proper
> >  > > form.  My OCSP responder also runs on Linux, rather=20
> than Windows.
> >  > >
> >  > >
> >  > >  -Dave
> >  > >
> >  > >  ...
> >  > >
> >  > > > Thank you for your tests!
> >  > >  >
> >  > >  > Your configuration is correct.
> >  > >  >
> >  > >  > Can you please double click the certificate at the MMC,
> >  > and  > see
> >  > > if it marked "OK"? If there is an error then there is=20=20
> > probably
> >  > > something wrong with CA location or CRL fetch.  >
> >  > >  > How did you enroll your certificate? If you did this via
> >  > >  > microsoft CA, you have CDP (CRL distribution point) X.509
> >  > >  > extension that is used by Windows to automatically=20
> fetch your
> >  > >  > CRL. If you got OCSP responder which is integrated with CAPI
> >  > >  > on your machine it will also work in this configuration.
> >  > >  >
> >  > >  > I added some more debugging information.
> >  > >  > Please run the new version [1] with verb 255.
> >  > >  > Thanks!
> >  > >
> >  > > ...
> >  > >
> >  > >
> >  >
> >
> > > --------------------------------------------------------------
> >  > -----------
> >  > This SF.Net email is sponsored by the Moblin Your Move
> >  > Developer's challenge Build the coolest Linux based
> >  > applications with Moblin SDK & win great prizes Grand=20
> prize  > is a=20
> > trip for two to an Open Source event anywhere in the  > world=20
> > http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
> >  > _______________________________________________
> >  > Openvpn-devel mailing list
> >  > Openvpn-devel@lists.sourceforge.net
> >  > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >  >
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


