Message-ID: <5200C76B.5030008@...1114...>
Date: Tue, 06 Aug 2013 11:52:43 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <kt8j7m$c5m$1@...1062...> <20130730145731.GW13127@...1152...>
	<20130730151406.GQ16543@...1296...>
	<51FA324F.1090108@...1147...>
	<20130801143058.GM16543@...1296...>
	<51FA79C6.1020405@...1147...> <51FEA1BF.9000905@...515...>
	<A3805A26-5FA4-461D-88C3-45E018208FD7@...277...>
In-Reply-To: <A3805A26-5FA4-461D-88C3-45E018208FD7@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="GG4PUXvC0lSxr3NjgQrMHIgLa11ojm3eI"
Subject: Re: [Openvpn-devel] [Openvpn-users] why doesn't openvpn negotiate
 settings?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: dan farmer <zenfish@...277...>
Cc: openvpn-devel@lists.sourceforge.net, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GG4PUXvC0lSxr3NjgQrMHIgLa11ojm3eI
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 05/08/13 19:52, dan farmer wrote:
>=20
> To start with - I really, really appreciate the work that's gone into the=
 program.
> I've released stuff myself, and it's not an easy process, especially for =
something
> as complex and with so much functionality as openvpn.  I get that.
>=20
> But from a user's perspective - anything that can make the horror known a=
s=20
> openvpn configuration easier would improve openvpn's adoption considerabl=
y.
>=20
> Here's a true tale.  I'm writing a little thing to use openvpn.  I'd like=
 to think I know=20
> networks a bit - more on the theory at times than implementation, but wha=
tever.
>=20
> OpenVPN ranks up there with pgp and openssh for the most fucked up and=20
> mysterious configurations I've ever seen (it is not a coincidence that th=
ey're
> all crypto programs, I believe.)  It is legendary among non-openvpn peopl=
e to
> be ridiculously difficult.   I'm actually pretty sure that if one is an o=
penvpn person
> who knows you're doing it's not that bad, or even makes some internal sen=
se.=20=20
> But I'd wager that high-ninety% of your user base doesn't fall into that =
camp.=20=20
> Well, of your potential user base, that is, most don't get that far.
>=20
> I am not saying this to say "everything is fuxx3d up" or something.  I'm =
telling
> you because it took me a couple of days to get even the most basic thing =
really
> working on a not-terribly-complex setup.  And while I understand the conc=
eptual
> matters of your program, honestly, I fear to set it up, and have little f=
aith that even
> if I get it running it'll do what I want it to.
>=20
> I'm not even complaining for myself - I'm a big guy, I can take care of m=
yself,=20
> and take it or leave it - but for others=85..

[...snip...]

The documentation to OpenVPN might feel daunting, but it really isn't
that bad if you just get started on the easy paths.  And if you really
want a hand-held guide through setting up OpenVPN ... go grab this book:

<http://www.packtpub.com/openvpn-2-cookbook/book>

I'm not aiming this message against you, Dan, so please don't take it as
an personal attack of any kind.

The biggest problem, from my experience, isn't that people don't
understand the official docs.  But they use external sources for setting
up OpenVPN, like random blog or forum posts on sites not controlled by
the OpenVPN community at all.  And really, in 99% of all those posts,
they contradict each other or basically recommend completely clueless
setups which are just plain wrong.  Why?  Because these writers often
don't understand NETWORKING at all.

First of all, if you want to setup any kind of VPN, you NEED to
understand basic networking.  If your network experience is based on
setting up a home router and you got it working, then you know NOTHING
about networking.  Go read about how TCP/IP functions and at minimum
learn the BASIC ROUTING.  Without that, you're going to get lost.

Next, OpenVPN configurations are basically 2 parts.  It's the security
part, which involves setting up security parameters (ciphers, keys, etc)
and which host to connect to.  The other part is NETWORK ROUTING.  No
matter what kind of VPN setup you configure, you must understand
routing.  Then there is the more advanced parts, such as firewalling,
MTU, fragmentation, and similar topics.

Most people I've met on #openvpn, in this mailing lists and those times
I've looked at our forum, they struggle with the latter.  Almost
everyone manages to set up and configure OpenVPN server and clients and
make them connect without much help at all (when having issues, it's
mostly related to PKI setups).  They usually show up when their brand
new OpenVPN setup doesn't pass traffic through their OpenVPN server or
client.  Which really makes me repeat what I've said in the two past
paragraphs: To setup VPN you MUST UNDERSTAND BASIC NETWORK ROUTING.  You
say "briding"? I'll repeat: NETWORK ROUTING.  Really!

And many of those who begin to struggle, seek help in various wikis,
blogs and whatever else they find.  But the *minority* of these sources
explains things correctly.  I think I've seen just a handful of those
thousands of blogs which really makes sense.  Unfortunately, I've not
indexed the good sources.

At the end, I'll provide a few pointers which hopefully can help people
solving their issues.

* Learn about TCP/IP networking, read especially chapter 3.1 in this
book: <http://www.redbooks.ibm.com/redbooks/pdfs/gg243376.pdf>.  I'll
repeat: You MUST know how network traffic travels between hosts and routers.

* Then first configure a very simple OpenVPN setup, based on this HOWTO:
<http://openvpn.net/index.php/open-source/documentation/miscellaneous/stati=
c-key-mini-howto.html>

Go through this one, step by step.

* Use the man page as a companion and read about what each option used
above does:
<https://community.openvpn.net/openvpn/wiki/Openvpn23ManPage>

* Extend the configuration above with a PKI setup (enhacned security):
<http://openvpn.net/index.php/open-source/documentation/howto.html#pki>

* Set up a reasonable routed network configuration with firewalling,
based on this one:
<https://community.openvpn.net/openvpn/wiki/BridgingAndRouting#Usingrouting>


By going through these steps, I believe most users should be able to set
up a working VPN.

But it's a lot to learn, if you haven't done this before.  There are no
shortcuts into setting up a VPN.  You simply must learn these basic
steps.  The cookbook I mentioned in the beginning might make things
easier to get started, but you still need to do some learning; at least
when things doesn't work as expected.


--=20
kind regards,

David Sommerseth


--GG4PUXvC0lSxr3NjgQrMHIgLa11ojm3eI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlIAx3AACgkQDC186MBRfrrbdACeLO5rEMPU2KeTdOazGKcGqbBM
0P4An3+IfnmRPzDGyIeLjWxXFo0H94jp
=Turt
-----END PGP SIGNATURE-----

--GG4PUXvC0lSxr3NjgQrMHIgLa11ojm3eI--

