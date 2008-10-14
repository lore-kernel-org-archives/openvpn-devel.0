Message-ID: <9e0cf0bf0810141215x7e11d0fcxbc117f7d054d4f03@...278...>
Date: Tue, 14 Oct 2008 21:15:41 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <7C342B9ABF73436EAE299A297BF7437D@...576...>
MIME-Version: 1.0
References: <9e0cf0bf0810112307p73010087r512098cb3d7092b8@...278...>
	<7C342B9ABF73436EAE299A297BF7437D@...576...>
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
Cc: Peter 'Luna' Runestig <peter@...292...>, openvpn devel <openvpn-devel@lists.sourceforge.net>

Thank you for your tests!

Your configuration is correct.

Can you please double click the certificate at the MMC, and see if it
marked "OK"? If there is an error then there is probably something
wrong with CA location or CRL fetch.

How did you enroll your certificate? If you did this via microsoft CA,
you have CDP (CRL distribution point) X.509 extension that is used by
Windows to automatically fetch your CRL. If you got OCSP responder
which is integrated with CAPI on your machine it will also work in
this configuration.

I added some more debugging information.
Please run the new version [1] with verb 255.
Thanks!

[1] http://alon.barlev.googlepages.com/openvpn-mscapi-test-4.tar.bz2

On 10/12/08, Dave <dev@...575...> wrote:
> I would consider [1] as verified, at least partially.  I did not try any
>  negative tests outside of the absence of the cert/key does not enable login,
>  also I did not try in the 'service' scenario, which I imagine just means
>  'put the cert in the machine's store'.
>
>  attached herewith is my log, and also my config file for reference.  the
>  error is on line 18.  I can re-run and bump up the verb, as 3 is probably
>  too low for you?
>
>  I would also like to test revocation, both by explicitly untrusting a cert,
>  and by having a crl.  When I import a CRL using the default 'choose a sane
>  place' option, it goes under
>
>  Intermediate Certification Authorities
>   Certificate Revocation List
>
>  which strikes me as odd since this is not an intermediate CA, and because
>  the CA cert went under the 'Trusted Root CA' as expected, and not the
>  'Intermediate CA'.  Such, I suppose, are the mysteries of capi.
>
>  It would be great if the 'CRL distribution point' and 'Authority Info
>  Access' 'OCSP' certificate extensions were used, but that's another
>  projectlette in itself, no?....
>
>
>  -Dave
>
>
>  > -----Original Message-----
>  > From: Alon Bar-Lev [mailto:alon.barlev@...277...]
>  > Sent: Sunday, October 12, 2008 1:07 AM
>  > To: Dave
>  > Cc: openvpn devel; Peter 'Luna' Runestig
>  > Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
>  >
>  >
>  > Thank you dave!
>  >
>  > Let's divide this into two threads.
>  >
>  > 1. I've cleanup the OpenSSL integration, this should not
>  > change existing behavior... All you need to verify that
>  > OpenVPN continue to work while using private key from CAPI store.
>  >
>  > 2. Add the CAPI certificate validation.
>  >
>  > From what I understand, (1) works at your side?
>  >
>  > For the VERIFY ERROR, can you please paste some more log
>  > lines? Should be something like "Failed to verify certificate..."
>  >
>  > Thanks!
>  > Alon.
>  >
>  > On 10/12/08, Dave <dev@...575...> wrote:
>  > > ...
>  > >
>  > > > ...
>  > >  > > As part of modification of the mscapi (cryptoapi.c)
>  > file, I  > >
>  > > try to cleanup the openssl usage. I don't have Windows  > >
>  > > environment to test.  > >
>  > >  > > I will be glad if users of this feature help me testing this.
>  > >
>  > > ...
>  > >
>  > > > ...
>  > >  > Sure, I could do it now but what are the test cases we
>  > are  > going
>  > > to run? This is for the cryptoapicert feature? -Dave  >
>  > >
>  > >
>  > > OK, I'm not getting it.  Educate me.  I am using an existing and
>  > > functional  server, and removed all the ca cert and key
>  > options in my
>  > > config and  replaced them with:
>  > >
>  > >   cryptoapica
>  > >   cryptoapicert "SUBJ:plexus"
>  > >
>  > >  Nevermind the second one -- I verified it works fine in isolation
>  > > (i.e.  meaning having ca or <ca> makes it work finding the cert and
>  > > key via capi).  That was mostly a 'using capi to do
>  > something at all'
>  > > sanity check.
>  > >
>  > >  I imported my CA cert.  I used the 'pick a sensible place'
>  > option.  I
>  > > verified that it is located (according to the MMC snapin) at:
>  > >
>  > >  Certificates - Current User
>  > >   Trusted Root Certification Authorities
>  > >     Certificates
>  > >
>  > >  which does seem a sensible place.
>  > >
>  > >  Upon connect, I am getting the error:
>  > >
>  > >  Sat Oct 11 22:25:16 2008 VERIFY ERROR: depth=1, error=self signed
>  > > certificate in certificate chain:
>  > >
>  > /C=US/ST=TX/L=Cedar_Park/O=ziggurat29/CN=ziggurat29_CA/emailAddress=de
>  > > v@...1136...
>  > >  urat29.com
>  > >
>  > >  Not sure what to say about that -- root CA certs are always
>  > > self-signed, no?
>  > >
>  > >  For fun I also imported the server cert.  It wound up at:
>  > >
>  > >  Certificates - Current User
>  > >   Other People
>  > >     Certificates
>  > >
>  > >  Didn't do any good there -- no surprise -- but I moved it
>  > over to the
>  > > trusted root CA and it did no good there either.
>  > >
>  > >  I'll be happy to give configs, logs, certs if it's useful.
>  > >
>  > >
>  > >  -Dave
>  > >
>  > >
>  >
>
>

