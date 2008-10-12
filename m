Message-ID: <9e0cf0bf0810112307p73010087r512098cb3d7092b8@...278...>
Date: Sun, 12 Oct 2008 08:07:17 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <4120B11CA86A4398B70DBF8257A0FD40@...576...>
MIME-Version: 1.0
References: <DE8C3B9CA5274760B7825A15F01AC51F@...576...>
	<4120B11CA86A4398B70DBF8257A0FD40@...576...>
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

Thank you dave!

Let's divide this into two threads.

1. I've cleanup the OpenSSL integration, this should not change
existing behavior... All you need to verify that OpenVPN continue to
work while using private key from CAPI store.

2. Add the CAPI certificate validation.

From what I understand, (1) works at your side?

For the VERIFY ERROR, can you please paste some more log lines? Should
be something like "Failed to verify certificate..."

Thanks!
Alon.

On 10/12/08, Dave <dev@...575...> wrote:
> ...
>
> > ...
>  > > As part of modification of the mscapi (cryptoapi.c) file, I
>  > > try to cleanup the openssl usage. I don't have Windows
>  > > environment to test.
>  > >
>  > > I will be glad if users of this feature help me testing this.
>
> ...
>
> > ...
>  > Sure, I could do it now but what are the test cases we are
>  > going to run? This is for the cryptoapicert feature? -Dave
>  >
>
>
> OK, I'm not getting it.  Educate me.  I am using an existing and functional
>  server, and removed all the ca cert and key options in my config and
>  replaced them with:
>
>   cryptoapica
>   cryptoapicert "SUBJ:plexus"
>
>  Nevermind the second one -- I verified it works fine in isolation (i.e.
>  meaning having ca or <ca> makes it work finding the cert and key via capi).
>  That was mostly a 'using capi to do something at all' sanity check.
>
>  I imported my CA cert.  I used the 'pick a sensible place' option.  I
>  verified that it is located (according to the MMC snapin) at:
>
>  Certificates - Current User
>   Trusted Root Certification Authorities
>     Certificates
>
>  which does seem a sensible place.
>
>  Upon connect, I am getting the error:
>
>  Sat Oct 11 22:25:16 2008 VERIFY ERROR: depth=1, error=self signed
>  certificate in certificate chain:
>  /C=US/ST=TX/L=Cedar_Park/O=ziggurat29/CN=ziggurat29_CA/emailAddress=dev@...1136...
>  urat29.com
>
>  Not sure what to say about that -- root CA certs are always self-signed, no?
>
>  For fun I also imported the server cert.  It wound up at:
>
>  Certificates - Current User
>   Other People
>     Certificates
>
>  Didn't do any good there -- no surprise -- but I moved it over to the
>  trusted root CA and it did no good there either.
>
>  I'll be happy to give configs, logs, certs if it's useful.
>
>
>  -Dave
>
>

