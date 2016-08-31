From: David Sommerseth <openvpn@...2080...>
Message-ID: <834c4ed9-af60-1f0b-091d-da0fafa6bd96@...2080...>
Date: Wed, 31 Aug 2016 20:55:07 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="JRBCLojEAl3fjNRB7TkkN0r0g8k2V6Ag4"
Subject: [Openvpn-devel] Modernising the management interface
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JRBCLojEAl3fjNRB7TkkN0r0g8k2V6Ag4
Content-Type: multipart/mixed; boundary="aLH8ftEJK7492MMB0788hmfDL4EgkfNRn"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <834c4ed9-af60-1f0b-091d-da0fafa6bd96@...2080...>
Subject: Modernising the management interface

--aLH8ftEJK7492MMB0788hmfDL4EgkfNRn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

I have for a long time pondered on how we can make the management API
more suitable for more modern tools and tasks.  So I am just giving an
extremely early heads-up on on what I'm poking at ... and hopefully
receive some feedbacks on what you think.

One of the things which have struck me is that D-Bus is adopted a lot
of places, and its internal API have been considered stable for about
10 years or more.  Even though there are areas where D-Bus seems a bit
over-engineered, it has proved to be a very useful IPC mechanism for a
lot of software.

Currently, each tool and application who wants to integrate with the
management API today, needs to write their own TCP connect code and
implement various methods to send, receive and parse the data to and
from the management interface.  And the management interface doesn't
scale well if you want to add support for more advanced management.

Yes, the current interface solves most of today's challenges
reasonably well.  But I believe it can be improved so that it can be
even more flexible and more easily integrable with various set of
management tools.


* Why D-Bus?
It provides a standardised API with integrations to most programming
and scripting languages.  It is asynchronous and it you can both send
messages but also have management tools act upon signals the
application sends.  The way messages are sent are standardised, and
all the connectivity and data exchange is covered by the D-Bus
libraries.  Even data types are standardised and there is type safety
on all data exchanged in a D-Bus message.

D-Bus is also pretty much installed by default on any modern Linux
distribution today.  And as far as I have seen, it exists on most
POSIX based platforms.  I am somewhat uncertain on the Windows and
macOS side, though.  More on that towards the end.


* How will a D-Bus improve OpenVPN?

With D-Bus we can provide a better integration towards GUIs as well as
other management tools.  OpenVPN can much more easy alert D-Bus
listeners about things which requires attention.  And we can more
easily extend the management interface to also cover more areas of
OpenVPN more easily, as D-Bus will describe the API through its
built-in introspection.

This can also enable us to provide plug-ins to be managed via the
management interface, where each plug-in can individually provide it's
own API without requiring any changes to the OpenVPN core.  The
plug-in just needs to provide an init call which tells the OpenVPN
server it has D-Bus support, and introspection takes care of providing
the proper message passing from a management client down to the
plug-in itself.

And it can enabled more modern and advanced management tools to be
integrated more easily with OpenVPN.  For example the Cockpit
project[1] is a a web based management interface for Linux systems
with systemd.  Cockpit depends entirely on D-Bus to do the management.
 Writing a new module in Cockpit requires only to write a module
covering the D-Bus methods defined in OpenVPN, the presentation and
interaction is covered by the Cockpit framework.  A demo how to
implement setting the time zone as a Cockpit module can be seen here[2].

[1] <http://cockpit-project.org/>
[2] <https://www.youtube.com/watch?v=3D97l1qf2sZtk&feature=3Dyoutu.be&t=3D1=
754>

Other features where this can be useful is to provide D-Bus signals
when users log in and out for audit purposes.  It is possible to add
methods where you can set thresholds on bytes sent/received or how
long a session have been running, and then send a signal when those
thresholds are reached; then a management tool can decide what to do
when these signals happens.  As a Cockpit feature, could be to list
all connected VPN clients on a Cockpit enabled OpenVPN server, and
have a button kick them out or otherwise manage these VPN clients.

Many of these things requires today a poll mechanism which doesn't
scale too well as only one instance can be connected to the management
API today.  With D-Bus you can have many instances connected to the
interfaces OpenVPN would provide at the same time - which again
simplifies implementing new management tools for OpenVPN.

Similar D-Bus interfaces will also be added to the OpenVPN 3 codebase
when that arrives, which should help migration between OpenVPN 2 and
OpenVPN 3 setups as well.


* What comes next?

Right now I am digging into the whole feature set of the management
interface and wrapping my head around how this could look like through
a D-Bus interface.

The next thing I am will do is to provide some proof-of-concept code,
which first will just connect to today's management API and be a
broker between OpenVPN and D-Bus.  This won't scale well, but it will
at least give something we can play with.

Then comes the job of implementing D-Bus natively into OpenVPN and
then start to provide more advanced features over D-Bus which today is
be harder to achieve.  This will be an iterative process.

But ... It would be very useful to get some input from especially
macOS and Windows developers on how the state of D-Bus are on those
platforms.  AFAIK, D-Bus is available on most *BSD platforms, so that
shouldn't be an issue.

It is not being planned to remove the management interface.  If D-Bus
works well for everyone on all platforms, then we can discuss what to
do next.  But as of now, I have no plans to remove this part of the code.

And of course ... plenty of discussions along the road :)  But I chose
to start this discussion in the public before actually starting to
coding and submitting patches - just as a heads up and to get feedback
before moving on further.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--aLH8ftEJK7492MMB0788hmfDL4EgkfNRn--

--JRBCLojEAl3fjNRB7TkkN0r0g8k2V6Ag4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXxygLAAoJEIbPlEyWcf3yW+IP/i8Qt+0EVHVCrg1pW81y2bDu
r0igd5T3aiXl8Op8qpdXtM6/Td8j98EXIxRFrYbyttlA5LRaKLGKcUkJmjaKLEq0
m5SHOJ2YhvnWnQPAiKPGMD+ZM560GzzHfbTlOJpBUwW5tUGboCd2w7fNIBL8J8Qh
FUFY4e+vdW/BuaQjyBlBbPSD0oZw3KJFN/wyeiQ+Pj/Y2donvE3qHY55ALrzANAM
o5Cuk/n/kYCF0us49hGprRFo1CsgezS9lQ4/nGHZ3drwR5YsXm3qdIGXBhyRXWQX
GpwSSqQB0K7LXEWBEle1CtpKKkKRyZjyvrxxsr/ce1o3bFexjaA4Qnzh2I/+L+Vi
Bae1WhVkdqULaD23UClDi9IvPWE1+pya8CCYxvN5j4Do0wue8yo7IX91hSyB0kFr
+MEcdZaRjBE2lmIGyuIn1HCB/SDA7tEhcKJiF1EdzsQQZYa60mQLpWKVLXjESYDN
ANXHkk+sDpNrqU5iHs+wZtceryaWNSMK5t/pGNOX9wdhyZkH2ssMBsjgZ7r0RdFj
UEO3iLoGrDRofq5yvvlAbWHpQAeqSE8SEt6dRsVp88tCkASQhLp44Uqzk4GmgX1f
iSuK5K0BfInM1nm39zOb8iWkin+Af2stwbsKciWL6DZITzqhMPr2zMqMfi4PJbGo
lWk3haryH50U3KnIkSzB
=hSB3
-----END PGP SIGNATURE-----

--JRBCLojEAl3fjNRB7TkkN0r0g8k2V6Ag4--

