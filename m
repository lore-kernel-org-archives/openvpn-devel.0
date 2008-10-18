Message-ID: <9e0cf0bf0810181419s4f5725cen6dd94cbbaa6d52f6@...278...>
Date: Sat, 18 Oct 2008 23:19:12 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <4D8505CAD86A42D0A8416848CB1D9825@...576...>
MIME-Version: 1.0
References: <9e0cf0bf0810181328wb5f5711g423a16b6f0bf673@...278...>
	<4D8505CAD86A42D0A8416848CB1D9825@...576...>
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

I think that missing CRL should fail. This is how MS is working. There
is no point in PKI without CRL...
If you want to do something other you can use the CTL feature of CAPI.

Thanks for testing!!!
Alon.

On 10/18/08, Dave <dev@...575...> wrote:
> OK better but not perfect:
>
>  1)  missing CA in trusted roots:  fails to verify; good
>  2)  missing CRL:  FAILS TO VERIFY; BAD
>  3)  CRL with revoked cert:  fails to verify, good
>  3.bis)  CRL _without_ revoked cert:  verifies, good
>
>  so it seems the coup-de-grace would be to make the absence of the CRL act
>  like nothing is revoked, or add some options/parameters, maybe like:
>
>     cryptoapi-chain-validation require-crl-present
>
>  I'd still like to see an example of a well-formed value for CDP, and
>  Authority Info Access extension so I can re-issue my CA cert and test the
>  hypothetical CAPI built-in OCSP/CRL checking....
>
>
>  -Dave
>
>  > -----Original Message-----
>  > From: Alon Bar-Lev [mailto:alon.barlev@...277...]
>
> > Sent: Saturday, October 18, 2008 3:29 PM
>  > To: Dave
>  > Cc: openvpn devel
>  > Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
>  >
>  >
>  > Oh!
>  > Thanks!!!!
>  > I feared I had to install Windows again :)
>  >
>  > So now everything should be fine... you should be able to
>  > check the chain validation... 1. Without trusted CA in store.
>  > 2. Without CRL in store. 3. With CRL but with certificate revoked.
>  >
>  > Alon.
>  >
>  > On 10/18/08, Dave <dev@...575...> wrote:
>  > > Sorry, I lied.  Success!  I somehow failed to copy the openvpn.exe
>  > > over.  Attached herewith is the log.
>  > >
>  > >
>  > >
>  > >  > -----Original Message-----
>  > >  > From: Dave [mailto:dev@...575...]
>  > >  > Sent: Saturday, October 18, 2008 3:19 PM
>  > >  > To: 'Alon Bar-Lev'
>  > >  > Cc: 'openvpn devel'
>  > >  > Subject: RE: [Openvpn-devel] [MSCAPI] Need testers
>  > >  >
>  > >  >
>  > >  > Alas, the same.
>  > >  >
>  > >  > > -----Original Message-----
>  > >  > > From: Alon Bar-Lev [mailto:alon.barlev@...277...]
>  > >  > > Sent: Saturday, October 18, 2008 2:31 PM
>  > >  > > To: Dave
>  > >  > > Cc: openvpn devel
>  > >  > > Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
>  > >  > >
>  > >  > >
>  > >  > > Thank you for your time!
>  > >  > > Last time... If we don't make any progress I will install  > >
>  > > Windows setup when I have some free time. The problem is
>  > may  > > be
>  > > due to RSA_FLAG_SIGN_VER flag that should be set on the  >
>  > > RSA and
>  > > not the method. Can you please test [1]?  > >
>  > >  > > Alon.
>  > >  > >
>  > >  > > [1]
>  > http://alon.barlev.googlepages.com/openvpn-mscapi-test-7.tar.bz2
>  > >  > >
>  > >  > > On 10/18/08, Dave <dev@...575...> wrote:
>  > >  > > > Nope, still crashes.
>  > >  > > >
>  > >  > > >  Application Event Log reveals:
>  > >  > > >
>  > >  > > >   Faulting application openvpn.exe, version 0.0.0.0,
>  > >  > > faulting module
>  > >  > > > libeay32.dll, version 0.9.9.0, fault address 0x0005c4c5.
>  > >  > > >
>  > >  > > >  I suppose there's no debug info in the MinGW build -- I
>  > >  > > can attach a
>  > >  > > > debugger when it crashes and could see the source if there
>  > >  > > was debug
>  > >  > > > info.  Invariably something about my config triggers
>  > some boundary
>  > >  > > > case.
>  > >  > > >
>  > >  > > >  When testing only with cryptoapicert, the failure occurs
>  > >  > > also, and is
>  > >  > > > logged  as having had happened at the same location.
>  > >  > > >
>  > >  > > >
>  > >  > > >  -Dave
>  > >  > > >
>  > >  > > >  > -----Original Message-----
>  > >  > > >  > From: Alon Bar-Lev [mailto:alon.barlev@...277...]
>  > >  > > >
>  > >  > > > > Sent: Saturday, October 18, 2008 1:51 PM
>  > >  > > >  > To: Dave
>  > >  > > >  > Cc: openvpn devel
>  > >  > > >  > Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
>  > >  > > >  >
>  > >  > > >  >
>  > >  > > >  > I cannot see what is wrong, what exactly crashes? Do you
>  > >  > > have  > an
>  > >  > > > entry in event log?, I recompiled everything at [1], I
>  > >  > may  > had a
>  > >  > > > problem with the libraries. Can you please test only  > with
>  > >  > > > cryptoapicert and see if it changes something?  >
>  > >  > > >  > Thanks!
>  > >  > > >  >
>  > >  > > >  > [1]
>  > >  > >
>  > http://alon.barlev.googlepages.com/openvpn-mscapi-test-6.tar.bz2
>  > >  > > >  >
>  > >  > > >  > On 10/18/08, Dave <dev@...575...> wrote:
>  > >  > > >  > > A little bit further, though now it crashes for me
>  > >  > > using all the
>  > >  > > >  > > binaries  you included in your bz file.  Log attached  >
>  > >  > > > herewith in case  > > that helps  locate the area affected.
>  > >  > > >  > >
>  > >  > > >  > >
>  > >  > > >  > >  -Dave
>  > >  > > >  > >
>  > >  > > >  > >  > -----Original Message-----
>  > >  > > >  > >  > From: Alon Bar-Lev [mailto:alon.barlev@...277...]
>  > >  > > >  > >
>  > >  > > >  > > > Sent: Saturday, October 18, 2008 1:01 PM
>  > >  > > >  > >  > To: Dave
>  > >  > > >  > >  > Cc: openvpn devel
>  > >  > > >  > >
>  > >  > > >  > > > Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
>  > >  > > >  > >  >
>  > >  > > >  > >  >
>  > >  > > >  > >
>  > >  > > >  > > > Thank you for testing!
>  > >  > > >  > >  >
>  > >  > > >  > >  > Found the problem... CryptoAPI cannot validate root
>  > >  > > >  > >  > certificate... OK, can you please test [1]?
>  > >  > > >  > >  >
>  > >  > > >  > >  > I also renamed the option from cryptoapica to
>  > >  > > >  > >  > cryptoapi-chain-validation, I think it is clearer.
>  > >  > > >  > >  >
>  > >  > > >  > >  > Thanks!
>  > >  > > >  > >  > Alon.
>  > >  > > >  > >  >
>  > >  > > >  > >  > [1]
>  > >  > > >  > >
>  > >  > >
>  > http://alon.barlev.googlepages.com/openvpn-mscapi-test-5.tar.bz2
>  > >  > > >  > >  >
>  > >  > > >  > >  > On 10/18/08, Dave <dev@...575...> wrote:
>  > >  > > >  > >  > > attached herewith is the log of the (failed)
>  > >  > > >  > attempt(s) to connect.
>  > >  > > >  > >  > >
>  > >  > > >  > >  > >  Certs are all OK as far as I can tell (no red X
>  > >  > > overlaid).
>  > >  > > >  > >  > >
>  > >  > > >  > >  > >  This CA cert I created some years back with
>  > >  > easy-RSA.  >
>  > >  > > > >  > These days I  > >  > > now  manage my CA with
>  > XCA off a USB
>  > >  > > > key, but I imported  > >  > that CA cert
>  > >  > > >  > >  > > rather than  rebuilding the PKI.
>  > >  > > >  > >  > >
>  > >  > > >  > >  > >  Your CRL/OCSP suggestion is interesting, though of
>  > >  > > >  > course that's
>  > >  > > >  > >  > > Windows  only (my servers are all Linux).
>  > >  > Actually I was
>  > >  > > >  > >  > hoping for
>  > >  > > >  > >  > > an extension of  the OCSP patch that was
>  > >  > submitted about a
>  > >  > > >  > >  > year ago,
>  > >  > > >  > >  > > but maybe that is a task  for me to do!
>  > Then it would
>  > >  > > >  > be general
>  > >  > > >  > >  > > across Windows/Linux.  I have not  used
>  > the extensions
>  > >  > > >  > >  > before, and I
>  > >  > > >  > >  > > would love it if you had an example cert  with
>  > >  > > the CDP or OCSP
>  > >  > > >  > >  > > extensions filled out so I can use that as a
>  > >  > reference  >
>  > >  > > > to proper  > >  > > form.  My OCSP responder also
>  > runs on Linux,
>  > >  > > > rather  > than Windows.
>  > >  > > >  > >  > >
>  > >  > > >  > >  > >
>  > >  > > >  > >  > >  -Dave
>  > >  > > >  > >  > >
>  > >  > > >  > >  > >  ...
>  > >  > > >  > >  > >
>  > >  > > >  > >  > > > Thank you for your tests!
>  > >  > > >  > >  > >  >
>  > >  > > >  > >  > >  > Your configuration is correct.
>  > >  > > >  > >  > >  >
>  > >  > > >  > >  > >  > Can you please double click the certificate
>  > >  > at the MMC,
>  > >  > > >  > >  > and  > see
>  > >  > > >  > >  > > if it marked "OK"? If there is an error
>  > then there is
>  > >  > > >  > > probably
>  > >  > > >  > >  > > something wrong with CA location or CRL fetch.  >
>  > >  > > >  > >  > >  > How did you enroll your certificate? If you
>  > >  > > did this via
>  > >  > > >  > >  > >  > microsoft CA, you have CDP (CRL distribution
>  > >  > > point) X.509
>  > >  > > >  > >  > >  > extension that is used by Windows to
>  > >  > automatically  >
>  > >  > > > fetch your  > >  > >  > CRL. If you got OCSP
>  > responder which is
>  > >  > > integrated with CAPI
>  > >  > > >  > >  > >  > on your machine it will also work in this
>  > >  > > configuration.
>  > >  > > >  > >  > >  >
>  > >  > > >  > >  > >  > I added some more debugging information.
>  > >  > > >  > >  > >  > Please run the new version [1] with verb
>  > >  > 255.  > >  > >
>  > >  > > > > Thanks!  > >  > >
>  > >  > > >  > >  > > ...
>  > >  > > >  > >  > >
>  > >  > > >  > >  > >
>  > >  > > >  > >  >
>  > >  > > >  > >
>  > >  > > >  > > >
>  > >  > > --------------------------------------------------------------
>  > >  > > >  > >  > -----------
>  > >  > > >  > >  > This SF.Net email is sponsored by the Moblin Your
>  > >  > Move  > >
>  > >  > > > > Developer's challenge Build the coolest Linux based  > >  >
>  > >  > > > applications with Moblin SDK & win great prizes Grand  >
>  > >  > prize  > is
>  > >  > > > a  > > trip for two to an Open Source event anywhere in
>  > >  > the  > world
>  > >  > > >  > >
>  > http://moblin-contest.org/redirect.php?banner_id=100&url=/
>  > >  > > >  > >  > _______________________________________________
>  > >  > > >  > >  > Openvpn-devel mailing list
>  > >  > > >  > >  > Openvpn-devel@lists.sourceforge.net
>  > >  > > >  > >  >
>  > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>  > >  > > >  > >  >
>  > >  > > >  > >
>  > >  > > >  > >
>  > >  > > >  >
>  > >  > > >  >
>  > --------------------------------------------------------------
>  > >  > > >  > -----------
>  > >  > > >  > This SF.Net email is sponsored by the Moblin Your Move
>  > >  > > >  > Developer's challenge Build the coolest Linux based
>  > >  > > >  > applications with Moblin SDK & win great prizes
>  > Grand prize
>  > >  > > >  > is a trip for two to an Open Source event anywhere in the
>  > >  > > >  > world
>  > >  > http://moblin-contest.org/redirect.php?banner_id=100&url=/
>  > >  > > >  > _______________________________________________
>  > >  > > >  > Openvpn-devel mailing list
>  > >  > > >  > Openvpn-devel@lists.sourceforge.net
>  > >  > > >  > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>  > >  > > >  >
>  > >  > > >
>  > >  > > >
>  > >  > >
>  > >  > > --------------------------------------------------------------
>  > >  > > -----------
>  > >  > > This SF.Net email is sponsored by the Moblin Your Move
>  > >  > > Developer's challenge Build the coolest Linux based
>  > >  > > applications with Moblin SDK & win great prizes Grand prize
>  > >  > > is a trip for two to an Open Source event anywhere in the
>  > >  > > world
>  > http://moblin-contest.org/redirect.php?banner_id=100&url=/
>  > >  > > _______________________________________________
>  > >  > > Openvpn-devel mailing list
>  > >  > > Openvpn-devel@lists.sourceforge.net
>  > >  > > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>  > >  > >
>  > >  >
>  > >
>  > >
>  >
>
>

