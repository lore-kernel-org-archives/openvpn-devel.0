References: <834c4ed9-af60-1f0b-091d-da0fafa6bd96@...2080...>
	<CAFHpkQEQUM7U40aYeKQy=rA7tiRcGxUrFxusOrLHhq-MfPUgrA@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3fda1204-41dc-39a2-4fe6-cad66cd86c88@...2080...>
Date: Wed, 31 Aug 2016 22:11:18 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEQUM7U40aYeKQy=rA7tiRcGxUrFxusOrLHhq-MfPUgrA@...278...>
Subject: Re: [Openvpn-devel] Modernising the management interface
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 31/08/16 21:37, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> I'd bet many people would like to see REST here

You might be right here.  But that would actually be far more
complicated to implement, as then OpenVPN needs to be a HTTP server -
with all the complications that involves.

In addition you loose some features, such as asynchronous
communication and the signalling (think "PUSH" instead of "POLL").
And the data types are loosely defined over a HTTP (unless you start
pulling in XML, DTD, Schemas, relaxng, etc).  Or to say it
differently, REST is more like an interface than an API itself.

However, with a D-Bus interface it actually is much easier to write a
REST-dbus bridge - as the D-Bus API is very well defined and offers
introspection to what is connected to the D-Bus.   That gives the
bonus that such a bridge can tackle more than just OpenVPN too.

For a D-Bus example - this one is in C:
<https://leonardoce.wordpress.com/2015/04/01/dbus-tutorial-a-simple-serv
er/>


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



> 2016-08-31 23:55 GMT+05:00 David Sommerseth=20
> <openvpn@...2080...=20
> <mailto:openvpn@...2080...>>:
>=20
>=20
> Hi,
>=20
> I have for a long time pondered on how we can make the management
> API more suitable for more modern tools and tasks.  So I am just
> giving an extremely early heads-up on on what I'm poking at ... and
> hopefully receive some feedbacks on what you think.
>=20
> One of the things which have struck me is that D-Bus is adopted a
> lot of places, and its internal API have been considered stable for
> about 10 years or more.  Even though there are areas where D-Bus
> seems a bit over-engineered, it has proved to be a very useful IPC
> mechanism for a lot of software.
>=20
> Currently, each tool and application who wants to integrate with
> the management API today, needs to write their own TCP connect code
> and implement various methods to send, receive and parse the data
> to and from the management interface.  And the management interface
> doesn't scale well if you want to add support for more advanced
> management.
>=20
> Yes, the current interface solves most of today's challenges=20
> reasonably well.  But I believe it can be improved so that it can
> be even more flexible and more easily integrable with various set
> of management tools.
>=20
>=20
> * Why D-Bus? It provides a standardised API with integrations to
> most programming and scripting languages.  It is asynchronous and
> it you can both send messages but also have management tools act
> upon signals the application sends.  The way messages are sent are
> standardised, and all the connectivity and data exchange is covered
> by the D-Bus libraries.  Even data types are standardised and there
> is type safety on all data exchanged in a D-Bus message.
>=20
> D-Bus is also pretty much installed by default on any modern Linux=20
> distribution today.  And as far as I have seen, it exists on most=20
> POSIX based platforms.  I am somewhat uncertain on the Windows and=20
> macOS side, though.  More on that towards the end.
>=20
>=20
> * How will a D-Bus improve OpenVPN?
>=20
> With D-Bus we can provide a better integration towards GUIs as well
> as other management tools.  OpenVPN can much more easy alert D-Bus=20
> listeners about things which requires attention.  And we can more=20
> easily extend the management interface to also cover more areas of=20
> OpenVPN more easily, as D-Bus will describe the API through its=20
> built-in introspection.
>=20
> This can also enable us to provide plug-ins to be managed via the=20
> management interface, where each plug-in can individually provide
> it's own API without requiring any changes to the OpenVPN core.
> The plug-in just needs to provide an init call which tells the
> OpenVPN server it has D-Bus support, and introspection takes care
> of providing the proper message passing from a management client
> down to the plug-in itself.
>=20
> And it can enabled more modern and advanced management tools to be=20
> integrated more easily with OpenVPN.  For example the Cockpit=20
> project[1] is a a web based management interface for Linux systems=20
> with systemd.  Cockpit depends entirely on D-Bus to do the
> management. Writing a new module in Cockpit requires only to write
> a module covering the D-Bus methods defined in OpenVPN, the
> presentation and interaction is covered by the Cockpit framework.
> A demo how to implement setting the time zone as a Cockpit module
> can be seen here[2].
>=20
> [1] <http://cockpit-project.org/> [2]=20
> <https://www.youtube.com/watch?v=3D97l1qf2sZtk&feature=3Dyoutu.be&t=3D1754
>
>=20
<https://www.youtube.com/watch?v=3D97l1qf2sZtk&feature=3Dyoutu.be&t=3D1754>>
>=20
> Other features where this can be useful is to provide D-Bus
> signals when users log in and out for audit purposes.  It is
> possible to add methods where you can set thresholds on bytes
> sent/received or how long a session have been running, and then
> send a signal when those thresholds are reached; then a management
> tool can decide what to do when these signals happens.  As a
> Cockpit feature, could be to list all connected VPN clients on a
> Cockpit enabled OpenVPN server, and have a button kick them out or
> otherwise manage these VPN clients.
>=20
> Many of these things requires today a poll mechanism which doesn't=20
> scale too well as only one instance can be connected to the
> management API today.  With D-Bus you can have many instances
> connected to the interfaces OpenVPN would provide at the same time
> - which again simplifies implementing new management tools for
> OpenVPN.
>=20
> Similar D-Bus interfaces will also be added to the OpenVPN 3
> codebase when that arrives, which should help migration between
> OpenVPN 2 and OpenVPN 3 setups as well.
>=20
>=20
> * What comes next?
>=20
> Right now I am digging into the whole feature set of the
> management interface and wrapping my head around how this could
> look like through a D-Bus interface.
>=20
> The next thing I am will do is to provide some proof-of-concept
> code, which first will just connect to today's management API and
> be a broker between OpenVPN and D-Bus.  This won't scale well, but
> it will at least give something we can play with.
>=20
> Then comes the job of implementing D-Bus natively into OpenVPN and=20
> then start to provide more advanced features over D-Bus which today
> is be harder to achieve.  This will be an iterative process.
>=20
> But ... It would be very useful to get some input from especially=20
> macOS and Windows developers on how the state of D-Bus are on
> those platforms.  AFAIK, D-Bus is available on most *BSD platforms,
> so that shouldn't be an issue.
>=20
> It is not being planned to remove the management interface.  If
> D-Bus works well for everyone on all platforms, then we can discuss
> what to do next.  But as of now, I have no plans to remove this
> part of the code.
>=20
> And of course ... plenty of discussions along the road :)  But I
> chose to start this discussion in the public before actually
> starting to coding and submitting patches - just as a heads up and
> to get feedback before moving on further.
>=20
>=20
> -- kind regards,
>=20
> David Sommerseth OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXxznlAAoJEIbPlEyWcf3yH5cP/i8yXnaiwC6yqyyfTaOtrfAR
m1TKn7w+AJDQdpQXylaj9FD3O3bYqOZ3fTPQG6u3iGk9MdyWWLdFHdOO/G/Vxadf
OH9WjFVYJOGj+IGb+wfH63qercregeALNz2AGlp0FJbvoPw3vNaviKg3OyIIiGPa
TogjIu59WYvbzxzwK5o1Vppy0sZZcKRDgKIw8hGxy4TR7V//bb0J5C8a0xQIVUY7
WRcCeMvUhz5lNsjM3fYOZ8lf3U7u0ny92c2VOxQGbSiOU9JKN5njlY5OhbtdgVU4
GjGhNOfkF6qUcUuojNwoqS1Reoyy/Wx9h0LOVSKZFmvJ3PN1MvBB6bNM0E2cOIjP
ZCL2YWV66iooBSBzuvN80DHB4FPxf0Nv0OgpsWTqEr3XScgAd4ybjfYyN3DpZJyF
pjkrN+VeQsigqRuPM6XqPv0pru/BbEIb89Zn/KfAwRe4DhkjFvviPg3reRJqH+TS
DEn6d11S5bTLFGmStCVrbxutFas5Lhwat9AipK/umIaJJ2qThDeuCpYAhPZp0tyR
t4lPNhfiVCjg+sf/cjU7w+wOCGy1Ntg3OKbUZBny0PU581c4PRLeII9NxFPhxI9c
GEBP0qAdAp90pUhfwwiEXteJTNAvvsM70TdhojB9W2P2LikHn+LCFyfKrNp+7t1Q
ljOIVpmJtW7UDuXxs6mt
=3D0tPq
-----END PGP SIGNATURE-----

