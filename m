From: "Dave" <dev@...575...>
Date: Sat, 11 Oct 2008 22:47:32 -0500
Message-ID: <4120B11CA86A4398B70DBF8257A0FD40@...576...>
MIME-Version: 1.0
In-Reply-To: <DE8C3B9CA5274760B7825A15F01AC51F@...576...>
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
To: 'Dave' <dev@...575...>, 'Alon Bar-Lev' <alon.barlev@...277...>, 'openvpn devel' <openvpn-devel@lists.sourceforge.net>
Cc: 'Peter 'Luna' Runestig' <peter@...292...>

...
> ...
> > As part of modification of the mscapi (cryptoapi.c) file, I
> > try to cleanup the openssl usage. I don't have Windows=20
> > environment to test.
> >=20
> > I will be glad if users of this feature help me testing this.
...
> ...
> Sure, I could do it now but what are the test cases we are=20
> going to run? This is for the cryptoapicert feature? -Dave
>=20

OK, I'm not getting it.  Educate me.  I am using an existing and functional
server, and removed all the ca cert and key options in my config and
replaced them with:

  cryptoapica
  cryptoapicert "SUBJ:plexus"

Nevermind the second one -- I verified it works fine in isolation (i.e.
meaning having ca or <ca> makes it work finding the cert and key via capi).
That was mostly a 'using capi to do something at all' sanity check.

I imported my CA cert.  I used the 'pick a sensible place' option.  I
verified that it is located (according to the MMC snapin) at:

Certificates - Current User
  Trusted Root Certification Authorities
    Certificates

which does seem a sensible place.

Upon connect, I am getting the error:

Sat Oct 11 22:25:16 2008 VERIFY ERROR: depth=3D1, error=3Dself signed
certificate in certificate chain:
/C=3DUS/ST=3DTX/L=3DCedar_Park/O=3Dziggurat29/CN=3Dziggurat29_CA/emailAddre=
ss=3Ddev@...1136...
urat29.com

Not sure what to say about that -- root CA certs are always self-signed, no?

For fun I also imported the server cert.  It wound up at:

Certificates - Current User
  Other People
    Certificates

Didn't do any good there -- no surprise -- but I moved it over to the
trusted root CA and it did no good there either.

I'll be happy to give configs, logs, certs if it's useful.

-Dave


