Message-ID: <9e0cf0bf0810191327m1904853fx539ecf55419a9d3c@...278...>
Date: Sun, 19 Oct 2008 22:27:01 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <BAB5AEF34D2B404FBEBE3DA8743BD603@...576...>
MIME-Version: 1.0
References: <465730FFADD349CF845F2B0CE8CA37D0@...576...>
	<BAB5AEF34D2B404FBEBE3DA8743BD603@...576...>
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

On 10/19/08, Dave <dev@...575...> wrote:
> OK, I built a new PKI and issued certs with both the CDP and/or/neither AIA
>  extensions.  Here are some observations for any interested:
>
>  *  The Crypto API will pick up the CRL automatically from the URI in the CDP
>  extension, if present.

True.

>  *  If it cannot be retrieved, validation fails.

True.

>  *  The CRL is pulled from the CDP in the CA certificate (i.e. not the end
>  entity certs)

Not true.
Each certificate is validated against the CRL referred via its own CDP
extension.
If there is CDP on root CA it can suicide.

>  *  The Crypto API caches this CRL for a period of time unknown to me.  For
>  those interested the cache locations is (approximately):

Until the CRL expires, there is an extension "Next update".

>     E:\Documents and Settings\{username}\Application
>  Data\Microsoft\CryptnetUrlCache\Content
>    (you'll have to substitute you user name and root drive letter in that
>  path).  You'll have to read into the content to find which file, but if you
>  sort by date, then that might make things easier if it is freshly
>  downloaded.  Deleting this file seems to have no consequences other than
>  causing it to be re-downloaded.

You cannot delete this file as it also cached in memory.
In the past I got a program from MS labs to refresh this cache.
At Vista there should be a process/service handling this cache.

>  *  The Crypto API seems to ignore the AIA extension, so no OCSP at all,
>  alas.

It does not ignore the AIA extension, it downloads the certificate of
the issuer via this extension.
For example, if you have Root->Sub->End

The End certificate AIA extension points to a URL from which Sub
certificate can be downloaded. This is how Windows builds the chain.

>  Some fun observations:
>
>  *  The Crypto API will ignore the CDP-fetched or even cached CRL if there is
>  an explicit one imported into the capi store.

It will use it as long as it is not expired.

> This would seem to open the
>  door to an 'unrevocation' attack, whereby one installs an old CRL that does
>  not contain certs revoked after it's creation, and thus those certs become
>  trusted again irrespective of their being in a currently distributed CRL
>  (via the CDP), or even a cached CRL that was downloaded prior to the
>  installation of the rogue CRL.

This is standard CRL behavior, it is valid as long as it is not expired.
You can determine this period in the CA configuration.
If you need instance reaction you need to use OCSP.

>  Some other observations:
>
>  *  _none_ of the Verisign CA certs installed on my XPSP3 machine have either
>  the CDP or AIA extension specified.  So I assume this would imply that if I
>  ran a server using a Verisign-issued cert, then it would never succeed to
>  validate client-side using the --cryptoapi-chain-validation option since I
>  do not have a CRL for that CA, nor is there a CDP extension specified in
>  it's root cert.  I don't' have the spare change to order a server cert from
>  Verisign for testing this hypothesis.

You need to look at the end certificates. Go browse to https site and
examine the certificate.
You will see AIA for certificate issued from third level, as there is
no actual need to find the root.

You can install OCSP client on your machine and it will be used
automatically. I heard that Vista has this built-in but never tested.

>  A tip for those wanting to use the --cryptoapi-chain-validation option, but
>  having an existing PKI and not wishing to completely rebuild it:
>
>  *  You can effectively re-issue your CA cert with the CDP option added (so
>  you don't have to rebuild the whole PKI) if you do the following:
>      *  use the exact same DN
>      *  use the same 'not before' time stamp
>      *  use a 'not after' timestamp later than the original
>      *  use the same private key
>      *  change whatever other option you like -- key usage, CDP, AIA, etc.
>    if you do this, then all the certs signed with the original CA cert will
>  still be valid with respect to the newly created (and modified) CA cert.

Thanks!

>
>
>  -Dave
>
>
>
>  > -----Original Message-----
>  > From: Dave [mailto:dev@...575...]
>
> > Sent: Saturday, October 18, 2008 6:08 PM
>  > To: 'Alon Bar-Lev'
>  > Cc: 'openvpn devel'
>
> > Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
>  >
>  >
>  > Gotcha.  I'm still sceptical but I certainly have been wrong
>  > before -- I'll double check my assumptions.
>  >
>  > Regarding VMWare, if you are able to install Windows in a
>  > compliant way at present, then presumably you could just as
>  > easily install in in VMWare and be in license compliance.  On
>  > the other hand, you need the VMWare license to create a new
>  > VM (though you can run an existing created VM for free,
>  > though, with player).
>  >
>  > > -----Original Message-----
>  > > From: Alon Bar-Lev [mailto:alon.barlev@...277...]
>  > > Sent: Saturday, October 18, 2008 4:48 PM
>  > > To: Dave
>  > > Cc: openvpn devel
>  > > Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
>  > >
>  > >
>  > > Hello,
>  > >
>  > > Microsoft complete the chain using CDP extension. This
>  > > extension contains the URL from which to fetch the CRL. So
>  > > you don't need to distribute the CRL by your self, you only
>  > > need to put this on accessible HTTP server. If you don't have
>  > > CDP you won't be able to work well within Microsoft domain.
>  > >
>  > > If you look at the CryptoAPI you will see that you cannot
>  > > determine if you have or don't have CRL in store. What you
>  > > request is not standard in Windows environment.
>  > >
>  > > Regarding VMWare and such... there is also a matter of
>  > > licensing, tools and time required... I thank you for
>  > > testing, I would have done so if the 7th round failed.
>  > >
>  > > Alon.
>  > >
>  > > On 10/18/08, Dave <dev@...575...> wrote:
>  > > > I would tend to disagree.  The only CRLs in my store are the one I
>  > > > added,  and an ancient Verisign one containing three
>  > infamous bogus
>  > > > Microsoft certs  they erroneously issued from 8 or so years
>  > > ago.  If
>  > > > the CRL (even an empty
>  > > >  one) were indeed required, then pretty much all certs I
>  > > have ever been
>  > > >  presented that were not Verisign would fail, no?
>  > > >
>  > > >  I recognize the merits of requiring a CRL be installed,
>  > > even empty,
>  > > > as a  matter of personal administrative policy.  I for one however
>  > > > don't intend to  distribute and install updated CRLs to all
>  > > my clients
>  > > > and servers upon each  change (hence my interest in the CDP and,
>  > > > preferably, OCSP, mechanisms).  I  would much rather the
>  > > absence of a
>  > > > CRL in CAPI to be treated as 'success'  and rely on another
>  > > > (centralized) mechanism to provide validation.
>  > > >
>  > > >  I forgot to mention in my previous email:  why don't you set up a
>  > > > VMWare  image for your Windows build/test environment.
>  > > This is what I
>  > > > do for my  five-or-so different build environments.
>  > > >
>  > > >
>  > > >  -Dave
>  > > >
>  > > >  > -----Original Message-----
>  > > >  > From: Alon Bar-Lev [mailto:alon.barlev@...277...]
>  > > >
>  > > > > Sent: Saturday, October 18, 2008 4:19 PM
>  > > >  > To: Dave
>  > > >  > Cc: openvpn devel
>  > > >  > Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
>  > > >  >
>  > > >  >
>  > > >  > I think that missing CRL should fail. This is how MS is  >
>  > > > working. There is no point in PKI without CRL... If you
>  > > want  > to
>  > > > do something other you can use the CTL feature of CAPI.
>  > >  > Thanks
>  > > > for testing!!!  > Alon.
>  > > >  >
>  > > >  > On 10/18/08, Dave <dev@...575...> wrote:
>  > > >  > > OK better but not perfect:
>  > > >  > >
>  > > >  > >  1)  missing CA in trusted roots:  fails to verify; good
>  > > >  > >  2)  missing CRL:  FAILS TO VERIFY; BAD
>  > > >  > >  3)  CRL with revoked cert:  fails to verify, good
>  > > >  > >  3.bis)  CRL _without_ revoked cert:  verifies, good
>  > > >  > >
>  > > >  > >  so it seems the coup-de-grace would be to make the absence
>  > > >  > of the CRL
>  > > >  > > act  like nothing is revoked, or add some
>  > > options/parameters, maybe
>  > > >  > > like:
>  > > >  > >
>  > > >  > >     cryptoapi-chain-validation require-crl-present
>  > > >  > >
>  > > >  > >  I'd still like to see an example of a well-formed
>  > value  > for
>  > > > CDP, and  > > Authority Info Access extension so I can
>  > re-issue my
>  > > > CA  > cert and test
>  > > >  > > the  hypothetical CAPI built-in OCSP/CRL checking....
>  > > >  > >
>  > > >  > >
>  > > >  > >  -Dave
>  > > >  > >
>  > > >  > >  > -----Original Message-----
>  > > >  > >  > From: Alon Bar-Lev [mailto:alon.barlev@...277...]
>  > > >  > >
>  > > >  > > > Sent: Saturday, October 18, 2008 3:29 PM
>  > > >  > >  > To: Dave
>  > > >  > >  > Cc: openvpn devel
>  > > >  > >  > Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
>  > > >  > >  >
>  > > >  > >  >
>  > > >  > >  > Oh!
>  > > >  > >  > Thanks!!!!
>  > > >  > >  > I feared I had to install Windows again :)
>  > > >  > >  >
>  > > >  > >  > So now everything should be fine... you should be able
>  > > >  > to  > check
>  > > >  > > the chain validation... 1. Without trusted CA in store.  >
>  > > >  > 2. Without
>  > > >  > > CRL in store. 3. With CRL but with certificate revoked.  >
>  > > >  > >  > Alon.
>  > > >  > >  >
>  > > >  > >  > On 10/18/08, Dave <dev@...575...> wrote:
>  > > >  > >  > > Sorry, I lied.  Success!  I somehow failed to copy the
>  > > >  > openvpn.exe
>  > > >  > >  > > over.  Attached herewith is the log.
>  > > >  > >  > >
>  > > >  > >  > >
>  > > >  > >  > >
>  > > >  > >  > >  > -----Original Message-----
>  > > >  > >  > >  > From: Dave [mailto:dev@...575...]
>  > > >  > >  > >  > Sent: Saturday, October 18, 2008 3:19 PM
>  > > >  > >  > >  > To: 'Alon Bar-Lev'
>  > > >  > >  > >  > Cc: 'openvpn devel'
>  > > >  > >  > >  > Subject: RE: [Openvpn-devel] [MSCAPI] Need testers
>  > > >  > >  > >  >
>  > > >  > >  > >  >
>  > > >  > >  > >  > Alas, the same.
>  > > >  > >  > >  >
>  > > >  > >  > >  > > -----Original Message-----
>  > > >  > >  > >  > > From: Alon Bar-Lev [mailto:alon.barlev@...277...]
>  > > >  > >  > >  > > Sent: Saturday, October 18, 2008 2:31 PM
>  > > >  > >  > >  > > To: Dave
>  > > >  > >  > >  > > Cc: openvpn devel
>  > > >  > >  > >  > > Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
>  > > >  > >  > >  > >
>  > > >  > >  > >  > >
>  > > >  > >  > >  > > Thank you for your time!
>  > > >  > >  > >  > > Last time... If we don't make any progress I will
>  > > >  > install  > >
>  > > >  > >  > > Windows setup when I have some free time. The problem is
>  > > >  > >  > may  > > be
>  > > >  > >  > > due to RSA_FLAG_SIGN_VER flag that should be
>  > set on the  >
>  > > >  > >  > > RSA and
>  > > >  > >  > > not the method. Can you please test [1]?  > >
>  > > >  > >  > >  > > Alon.
>  > > >  > >  > >  > >
>  > > >  > >  > >  > > [1]
>  > > >  > >  >
>  > > http://alon.barlev.googlepages.com/openvpn-mscapi-test-7.tar.bz2
>  > > >  > >  > >  > >
>  > > >  > >  > >  > > On 10/18/08, Dave <dev@...575...>
>  > wrote:  > >  >
>  > > > >  > > > Nope, still crashes.  > >  > >  > > >
>  > > >  > >  > >  > > >  Application Event Log reveals:
>  > > >  > >  > >  > > >
>  > > >  > >  > >  > > >   Faulting application openvpn.exe,
>  > > version 0.0.0.0,
>  > > >  > >  > >  > > faulting module
>  > > >  > >  > >  > > > libeay32.dll, version 0.9.9.0, fault
>  > > address 0x0005c4c5.
>  > > >  > >  > >  > > >
>  > > >  > >  > >  > > >  I suppose there's no debug info in the
>  > > MinGW build -- I
>  > > >  > >  > >  > > can attach a
>  > > >  > >  > >  > > > debugger when it crashes and could see the  >
>  > > > source if there  > >  > >  > > was debug
>  > > >  > >  > >  > > > info.  Invariably something about my
>  > > config triggers
>  > > >  > >  > some boundary
>  > > >  > >  > >  > > > case.
>  > > >  > >  > >  > > >
>  > > >  > >  > >  > > >  When testing only with cryptoapicert, the  >
>  > > > failure occurs  > >  > >  > > also, and is
>  > > >  > >  > >  > > > logged  as having had happened at the same
>  > > location.
>  > > >  > >  > >  > > >
>  > > >  > >  > >  > > >
>  > > >  > >  > >  > > >  -Dave
>  > > >  > >  > >  > > >
>  > > >  > >  > >  > > >  > -----Original Message-----
>  > > >  > >  > >  > > >  > From: Alon Bar-Lev
>  > > [mailto:alon.barlev@...277...]
>  > > >  > >  > >  > > >
>  > > >  > >  > >  > > > > Sent: Saturday, October 18, 2008 1:51
>  > PM  > >  >
>  > > > >  > > >  > To: Dave  > >  > >  > > >  > Cc: openvpn devel
>  > > >  > >  > >  > > >  > Subject: Re: [Openvpn-devel] [MSCAPI]
>  > > Need testers
>  > > >  > >  > >  > > >  >
>  > > >  > >  > >  > > >  >
>  > > >  > >  > >  > > >  > I cannot see what is wrong, what exactly  >
>  > > > crashes? Do you  > >  > >  > > have  > an
>  > > >  > >  > >  > > > entry in event log?, I recompiled
>  > > everything at [1], I
>  > > >  > >  > >  > may  > had a
>  > > >  > >  > >  > > > problem with the libraries. Can you
>  > please test  >
>  > > > only  > with  > >  > >  > > > cryptoapicert and see if it changes
>  > > > something?  >  > >  > >  > > >  > Thanks!
>  > > >  > >  > >  > > >  >
>  > > >  > >  > >  > > >  > [1]
>  > > >  > >  > >  > >
>  > > >  > >  >
>  > > http://alon.barlev.googlepages.com/openvpn-mscapi-test-6.tar.bz2
>  > > >  > >  > >  > > >  >
>  > > >  > >  > >  > > >  > On 10/18/08, Dave
>  > <dev@...575...> wrote:  >
>  > > > >  > >  > > >  > > A little bit further, though now it
>  > > crashes for me
>  > > >  > >  > >  > > using all the
>  > > >  > >  > >  > > >  > > binaries  you included in your bz
>  > file.  > Log
>  > > > attached  >  > >  > >  > > > herewith in case  > > that helps
>  > > > locate the  > area affected.
>  > > >  > >  > >  > > >  > >
>  > > >  > >  > >  > > >  > >
>  > > >  > >  > >  > > >  > >  -Dave
>  > > >  > >  > >  > > >  > >
>  > > >  > >  > >  > > >  > >  > -----Original Message-----
>  > > >  > >  > >  > > >  > >  > From: Alon Bar-Lev
>  > > >  > [mailto:alon.barlev@...277...]
>  > > >  > >  > >  > > >  > >
>  > > >  > >  > >  > > >  > > > Sent: Saturday, October 18, 2008 1:01 PM
>  > > >  > >  > >  > > >  > >  > To: Dave
>  > > >  > >  > >  > > >  > >  > Cc: openvpn devel
>  > > >  > >  > >  > > >  > >
>  > > >  > >  > >  > > >  > > > Subject: Re: [Openvpn-devel] [MSCAPI]
>  > > >  > Need testers
>  > > >  > >  > >  > > >  > >  >
>  > > >  > >  > >  > > >  > >  >
>  > > >  > >  > >  > > >  > >
>  > > >  > >  > >  > > >  > > > Thank you for testing!
>  > > >  > >  > >  > > >  > >  >
>  > > >  > >  > >  > > >  > >  > Found the problem... CryptoAPI cannot
>  > > >  > validate root
>  > > >  > >  > >  > > >  > >  > certificate... OK, can you
>  > please test [1]?
>  > > >  > >  > >  > > >  > >  >
>  > > >  > >  > >  > > >  > >  > I also renamed the option from
>  > > cryptoapica to
>  > > >  > >  > >  > > >  > >  > cryptoapi-chain-validation, I
>  > think it  >
>  > > > is clearer.  > >  > >  > > >  > >  >
>  > > >  > >  > >  > > >  > >  > Thanks!
>  > > >  > >  > >  > > >  > >  > Alon.
>  > > >  > >  > >  > > >  > >  >
>  > > >  > >  > >  > > >  > >  > [1]
>  > > >  > >  > >  > > >  > >
>  > > >  > >  > >  > >
>  > > >  > >  >
>  > > http://alon.barlev.googlepages.com/openvpn-mscapi-test-5.tar.bz2
>  > > >  > >  > >  > > >  > >  >
>  > > >  > >  > >  > > >  > >  > On 10/18/08, Dave
>  > > <dev@...575...> wrote:
>  > > >  > >  > >  > > >  > >  > > attached herewith is the log of
>  > > the (failed)
>  > > >  > >  > >  > > >  > attempt(s) to connect.
>  > > >  > >  > >  > > >  > >  > >
>  > > >  > >  > >  > > >  > >  > >  Certs are all OK as far as I
>  > can  > tell
>  > > > (no red X  > >  > >  > > overlaid).
>  > > >  > >  > >  > > >  > >  > >
>  > > >  > >  > >  > > >  > >  > >  This CA cert I created some
>  > > years back with
>  > > >  > >  > >  > easy-RSA.  >
>  > > >  > >  > >  > > > >  > These days I  > >  > > now  manage
>  > my CA with
>  > > > > >  > XCA off a USB  > >  > >  > > > key, but I imported  > >  >
>  > > > that CA cert  > >  > >  > > >  > >  > > rather than
>  > rebuilding the
>  > > > PKI.  > >  > >  > > >  > >  > >
>  > > >  > >  > >  > > >  > >  > >  Your CRL/OCSP suggestion is
>  > > >  > interesting, though of
>  > > >  > >  > >  > > >  > course that's
>  > > >  > >  > >  > > >  > >  > > Windows  only (my servers are
>  > all Linux).
>  > > >  > >  > >  > Actually I was
>  > > >  > >  > >  > > >  > >  > hoping for
>  > > >  > >  > >  > > >  > >  > > an extension of  the OCSP
>  > patch that was
>  > > >  > >  > >  > submitted about a
>  > > >  > >  > >  > > >  > >  > year ago,
>  > > >  > >  > >  > > >  > >  > > but maybe that is a task  for me to do!
>  > > >  > >  > Then it would
>  > > >  > >  > >  > > >  > be general
>  > > >  > >  > >  > > >  > >  > > across Windows/Linux.  I have not  used
>  > > >  > >  > the extensions
>  > > >  > >  > >  > > >  > >  > before, and I
>  > > >  > >  > >  > > >  > >  > > would love it if you had an
>  > > example cert  with
>  > > >  > >  > >  > > the CDP or OCSP
>  > > >  > >  > >  > > >  > >  > > extensions filled out so I can
>  > > use that as a
>  > > >  > >  > >  > reference  >
>  > > >  > >  > >  > > > to proper  > >  > > form.  My OCSP
>  > responder also
>  > > > > >  > runs on Linux,  > >  > >  > > > rather  > than Windows.
>  > > >  > >  > >  > > >  > >  > >
>  > > >  > >  > >  > > >  > >  > >
>  > > >  > >  > >  > > >  > >  > >  -Dave
>  > > >  > >  > >  > > >  > >  > >
>  > > >  > >  > >  > > >  > >  > >  ...
>  > > >  > >  > >  > > >  > >  > >
>  > > >  > >  > >  > > >  > >  > > > Thank you for your tests!
>  > > >  > >  > >  > > >  > >  > >  >
>  > > >  > >  > >  > > >  > >  > >  > Your configuration is correct.
>  > > >  > >  > >  > > >  > >  > >  >
>  > > >  > >  > >  > > >  > >  > >  > Can you please double click
>  > > the certificate
>  > > >  > >  > >  > at the MMC,
>  > > >  > >  > >  > > >  > >  > and  > see
>  > > >  > >  > >  > > >  > >  > > if it marked "OK"? If there is
>  > an error
>  > > > > >  > then there is  > >  > >  > > >  > > probably
>  > > >  > >  > >  > > >  > >  > > something wrong with CA location or
>  > > >  > CRL fetch.  >
>  > > >  > >  > >  > > >  > >  > >  > How did you enroll your
>  > > certificate? If you
>  > > >  > >  > >  > > did this via
>  > > >  > >  > >  > > >  > >  > >  > microsoft CA, you have CDP (CRL  >
>  > > > distribution  > >  > >  > > point) X.509
>  > > >  > >  > >  > > >  > >  > >  > extension that is used by Windows to
>  > > >  > >  > >  > automatically  >
>  > > >  > >  > >  > > > fetch your  > >  > >  > CRL. If you got OCSP
>  > > >  > >  > responder which is
>  > > >  > >  > >  > > integrated with CAPI
>  > > >  > >  > >  > > >  > >  > >  > on your machine it will also
>  > > work in this
>  > > >  > >  > >  > > configuration.
>  > > >  > >  > >  > > >  > >  > >  >
>  > > >  > >  > >  > > >  > >  > >  > I added some more debugging
>  > > information.
>  > > >  > >  > >  > > >  > >  > >  > Please run the new version
>  > > [1] with verb
>  > > >  > >  > >  > 255.  > >  > >
>  > > >  > >  > >  > > > > Thanks!  > >  > >
>  > > >  > >  > >  > > >  > >  > > ...
>  > > >  > >  > >  > > >  > >  > >
>  > > >  > >  > >  > > >  > >  > >
>  > > >  > >  > >  > > >  > >  >
>  > > >  > >  > >  > > >  > >
>  > > >  > >  > >  > > >  > > >
>  > > >  > >  > >  > >
>  > > >  > --------------------------------------------------------------
>  > > >  > >  > >  > > >  > >  > -----------
>  > > >  > >  > >  > > >  > >  > This SF.Net email is sponsored by the  >
>  > > > Moblin Your  > >  > >  > Move  > >
>  > > >  > >  > >  > > > > Developer's challenge Build the coolest Linux
>  > > >  > based  > >  >
>  > > >  > >  > >  > > > applications with Moblin SDK & win great
>  > > prizes Grand  >
>  > > >  > >  > >  > prize  > is
>  > > >  > >  > >  > > > a  > > trip for two to an Open Source
>  > > event anywhere in
>  > > >  > >  > >  > the  > world
>  > > >  > >  > >  > > >  > >
>  > > >  > >  > http://moblin-contest.org/redirect.php?banner_id=100&url=/
>  > > >  > >  > >  > > >  > >  >
>  > > _______________________________________________
>  > > >  > >  > >  > > >  > >  > Openvpn-devel mailing list
>  > > >  > >  > >  > > >  > >  > Openvpn-devel@lists.sourceforge.net
>  > > >  > >  > >  > > >  > >  >
>  > > >  > >  > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>  > > >  > >  > >  > > >  > >  >
>  > > >  > >  > >  > > >  > >
>  > > >  > >  > >  > > >  > >
>  > > >  > >  > >  > > >  >
>  > > >  > >  > >  > > >  >
>  > > >  > >  >
>  > > --------------------------------------------------------------
>  > > >  > >  > >  > > >  > -----------
>  > > >  > >  > >  > > >  > This SF.Net email is sponsored by the
>  > Moblin  >
>  > > > Your Move  > >  > >  > > >  > Developer's challenge Build the
>  > > > coolest
>  > > Linux based
>  > > >  > >  > >  > > >  > applications with Moblin SDK & win
>  > great prizes
>  > > > > >  > Grand prize  > >  > >  > > >  > is a trip for two
>  > to an Open
>  > > > Source event  > anywhere in the
>  > > >  > >  > >  > > >  > world
>  > > >  > >  > >  >
>  > > http://moblin-contest.org/redirect.php?banner_id=100&url=/
>  > > >  > >  > >  > > >  >
>  > _______________________________________________
>  > > >  > >  > >  > > >  > Openvpn-devel mailing list
>  > > >  > >  > >  > > >  > Openvpn-devel@lists.sourceforge.net
>  > > >  > >  > >  > > >  >
>  > > >  > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>  > > >  > >  > >  > > >  >
>  > > >  > >  > >  > > >
>  > > >  > >  > >  > > >
>  > > >  > >  > >  > >
>  > > >  > >  > >  > >
>  > > >  > --------------------------------------------------------------
>  > > >  > >  > >  > > -----------
>  > > >  > >  > >  > > This SF.Net email is sponsored by the Moblin
>  > > Your Move
>  > > >  > >  > >  > > Developer's challenge Build the coolest
>  > Linux based
>  > > > > >  > >  > > applications with Moblin SDK & win great prizes  >
>  > > > Grand prize  > >  > >  > > is a trip for two to an Open
>  > Source event
>  > > anywhere in the
>  > > >  > >  > >  > > world
>  > > >  > >  > http://moblin-contest.org/redirect.php?banner_id=100&url=/
>  > > >  > >  > >  > > _______________________________________________
>  > > >  > >  > >  > > Openvpn-devel mailing list
>  > > >  > >  > >  > > Openvpn-devel@lists.sourceforge.net
>  > > >  > >  > >  > >
>  > > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>  > > >  > >  > >  > >
>  > > >  > >  > >  >
>  > > >  > >  > >
>  > > >  > >  > >
>  > > >  > >  >
>  > > >  > >
>  > > >  > >
>  > > >  >
>  > > >  > --------------------------------------------------------------
>  > > >  > -----------
>  > > >  > This SF.Net email is sponsored by the Moblin Your Move
>  > > >  > Developer's challenge Build the coolest Linux based
>  > > >  > applications with Moblin SDK & win great prizes Grand
>  > prize  > is
>  > > > a trip for two to an Open Source event anywhere in the  > world
>  > > > http://moblin-contest.org/redirect.php?banner_id=100&url=/
>  > > >  > _______________________________________________
>  > > >  > Openvpn-devel mailing list
>  > > >  > Openvpn-devel@lists.sourceforge.net
>  > > >  > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>  > > >  >
>  > > >
>  > > >
>  > >
>  > > --------------------------------------------------------------
>  > > -----------
>  > > This SF.Net email is sponsored by the Moblin Your Move
>  > > Developer's challenge Build the coolest Linux based
>  > > applications with Moblin SDK & win great prizes Grand prize
>  > > is a trip for two to an Open Source event anywhere in the
>  > > world http://moblin-contest.org/redirect.php?banner_id=100&url=/
>  > > _______________________________________________
>  > > Openvpn-devel mailing list
>  > > Openvpn-devel@lists.sourceforge.net
>  > > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>  > >
>  >
>  >
>  > --------------------------------------------------------------
>  > -----------
>  > This SF.Net email is sponsored by the Moblin Your Move
>  > Developer's challenge
>  > Build the coolest Linux based applications with Moblin SDK &
>  > win great prizes
>  > Grand prize is a trip for two to an Open Source event
>  > anywhere in the world
>  > http://moblin-contest.org/redirect.php?banner_id=100&url=/
>  > _______________________________________________
>  > Openvpn-devel mailing list
>  > Openvpn-devel@lists.sourceforge.net
>  > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>  >
>
>

