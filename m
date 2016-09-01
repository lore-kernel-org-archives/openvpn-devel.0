References: <834c4ed9-af60-1f0b-091d-da0fafa6bd96@...2080...>
	<e4f4eee2-56f8-ac81-2c5a-354dfd1b27be@...2080...>
	<19b5f6f9-5504-d2c1-07a2-c6d498a118f7@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5c87fb3f-bd03-167c-bc58-fa586fb48346@...2080...>
Date: Thu, 1 Sep 2016 22:56:48 +0200
MIME-Version: 1.0
In-Reply-To: <19b5f6f9-5504-d2c1-07a2-c6d498a118f7@...277...>
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/09/16 22:14, debbie10t wrote:
> * If it sounds too good to be true .. then it probably is.

There's a good intro to D-Bus programming here, with focus on C:
<https://leonardoce.wordpress.com/2015/04/01/dbus-tutorial-a-simple-serv
er/>

Here's one I haven't looked too careful at, but related to Python:
<https://georgemuraruc.wordpress.com/2015/07/16/d-bus-tutorial-for-pytho
n/>

And for some good shell fun:
(this should work on most modern Linux distros)

$ gdbus call --system -d org.freedesktop.NetworkManager \
           -o /org/freedesktop/NetworkManager \
           -m org.freedesktop.NetworkManager.GetDevices
Returns on my laptop:

([objectpath '/org/freedesktop/NetworkManager/Devices/0',
 '/org/freedesktop/NetworkManager/Devices/1',
 '/org/freedesktop/NetworkManager/Devices/2'],)

To query everything about one of the devices, to see all methods,
signals and properties available you do this:

$ gdbus introspect --system -d org.freedesktop.NetworkManager \
            -o /org/freedesktop/NetworkManager/Devices/1

Through gdbus, you can do a lot of fun stuff.  If you are on a systemd
based system, you can even start and stop services through D-Bus calls
- - if you have the right privileges.

D-Bus has been around for over a decade and is very stable and widely
used, at least on the Linux side - but I believe it's a requirement if
you use GNOME or KDE too, regardless if it is Linux or not.

> If it is possible; a run time option eg. --dbus enabled|disabled or
> at least a compile time option --enable-dbus might be preferable.

Okay, there will be two ways to enable/disable.  D-Bus will be
disabled by default.

To enable D-Bus you must first compile it with D-Bus support, that
will be done via   ./configure --enable-dbus

Then to enable the D-Bus API, where OpenVPN will connect and register
to the D-Bus, you will need --management-dbus in your config.  This
option will only be available if built with --enable-dbus when running
./configure.

> For me personally, it sounds like a lot of openvpn 'control' is
> being handed over to another entity and I am not convinced that is
> ideal.

It is completely optional.  Without activating D-Bus, OpenVPN will
work just as before.  But there are use cases where the interfacing
possibilities to managing OpenVPN are very limited - and if not
limited, it is hard to accomplish.  I want to lower this barrier, to
allow simpler integration with tools and which is more agnostic to
programming languages and scripts.

D-Bus is first of all an API for interprocess communication (IPC), but
it has standardised how services are offered through that API so you
don't need to re-invent the wheel each time you want to do anything new.

In regards to handing over 'control', this is not much more different
than using the script hooks or enabling third-party plugins.  The
difference is that you can integrate using an API which is available
through the most common programming and scripting languages (C/C++,
Java, C#, golang, Python, Ruby, Perl, Haskel, Erlang, LUA, etc, etc).

And I emphasize again: D-Bus provides a much better control over whom
can do what on services provided over the D-Bus.  Every user or
process accessing a service is authenticated and access control is
managed through polkit policies.  Thus you can actually improve the
overall security by using D-Bus compared to using script hooks or even
plug-ins - where they at least run with the same privileges as the
openvpn process, if they haven't fork()ed out a root process (like the
down-root plugin does).


- --=20
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXyJYQAAoJEIbPlEyWcf3yfcEP/jjF4tjk2dTjhcJMVyZMCotH
vM5uApgA6uGmV7DcR4MXTxzn29rqS1nppoqlRNtC+znqvraeXJjddhrCUFq5QRmr
fowjbtRDMyXGTC5QZeDqfKO0CmqUzh6B+zqNrMeDU/vbaLVcL6NGHXP4yWTNyvmz
9lPGAuiwv195/vDf0mlKq5OM9m+peyTY3eGp+lEzDVaKdlb1CatXYEnVbSK7wCUl
daZPEaxKTKEVdGDs7DQdSMLDU+ix76KZ/CZSTmKaXAPtjGB9aQ2WiRSFp5PWkRLB
jkCmd9eyyEsGvsqgBlkVJ6rOXhpv+nQpHGYyTm3uQ+hSqcA8QKHK9S13j+5NYZbs
OOG2H9PM9AoGNWYRBi9BaW3LYyAS7r6o+P3VSeBRhHvZXmKkuEZVYhVpn/OAjokX
bUzVyYhc5PXCkRKAmviPm7aQBipP7KofM4T9+y4MBThw00PMm1UWrnkHm53qck6+
apcBx74mbF3ySW1xZIiRupTREBuca57UJ5Agh+cf2L6q5BWaXCbsnQkgKzgfx0Cf
mQXJSmnYNoVQBmb9TSps1J1ShL9rBkS27TbIcVHYsihibDHjaG/5PpyEa9cTxkya
o0alVbButYE6nqy5KCWEjxPFDImQM9MEOyC7LMzsZTuDzUNu+ADy+3xBFETqdqfV
RVXpwSkxIPYWAWbUeU17
=3DRmzu
-----END PGP SIGNATURE-----

