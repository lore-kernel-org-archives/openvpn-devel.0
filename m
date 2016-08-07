References: <1451908945-12244-1-git-send-email-lstipakov@...277...>
	<1451911424-12970-1-git-send-email-lstipakov@...277...>
	<5704F4E9.4050801@...2070...>
	<20160406145137.GY53051@...1296...>
	<57057532.1090606@...2070...>
	<20160611110510.GO62247@...1296...>
From: ValdikSS <iam@...2070...>
Message-ID: <4ecf4315-54c8-4ad5-c1ad-e63be411a81f@...2070...>
Date: Sun, 7 Aug 2016 20:15:19 +0300
MIME-Version: 1.0
In-Reply-To: <20160611110510.GO62247@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JiMXEqk0v2TiVhA17KkSUCTNivUA8iXqo"
Subject: Re: [Openvpn-devel] [PATCH v2] Drop recursively routed packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JiMXEqk0v2TiVhA17KkSUCTNivUA8iXqo
Content-Type: multipart/mixed; boundary="rg3csjKADEroMeah8u8UC6RvqFrnm1wew"
From: ValdikSS <iam@...2070...>
To: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <4ecf4315-54c8-4ad5-c1ad-e63be411a81f@...2070...>
Subject: Re: [PATCH v2] Drop recursively routed packets
References: <1451908945-12244-1-git-send-email-lstipakov@...277...>
	<1451911424-12970-1-git-send-email-lstipakov@...277...>
	<5704F4E9.4050801@...2070...>
	<20160406145137.GY53051@...1296...>
	<57057532.1090606@...2070...>
	<20160611110510.GO62247@...1296...>
In-Reply-To: <20160611110510.GO62247@...1296...>

--rg3csjKADEroMeah8u8UC6RvqFrnm1wew
Content-Type: multipart/alternative;
	boundary="------------023E0CC6DC379F8736EF3E71"

This is a multi-part message in MIME format.
--------------023E0CC6DC379F8736EF3E71
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Tested on Windows 10 and Linux. Works as intended.
I've connected to the VPN which redirects the gateway and physically unplug=
ged Ethernet cable. Git version started to consume 100% CPU while patched v=
ersion
either doesn't consume CPU and doesn't print anything or doesn't consume CP=
U and print 5-10 messages per second to the log with verb 4.

On 06/11/2016 02:05 PM, Gert Doering wrote:
> Hi,
>
> On Wed, Apr 06, 2016 at 11:44:34PM +0300, ValdikSS wrote:
> Coming back to this patch set - could you share your test results?
>
> I'll then go and see that I can code review & merge during the next week.
>
> gert
>
>
>
>
> -------------------------------------------------------------------------=
-----
> What NetFlow Analyzer can do for you? Monitors network bandwidth and traf=
fic
> patterns at an interface-level. Reveals which users, apps, and protocols =
are=20
> consuming the most bandwidth. Provides multi-vendor support for NetFlow,=
=20
> J-Flow, sFlow and other flows. Make informed decisions using capacity=20
> planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------023E0CC6DC379F8736EF3E71
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    Tested on Windows 10 and Linux. Works as intended.<br>
    I've connected to the VPN which redirects the gateway and physically
    unplugged Ethernet cable. Git version started to consume 100% CPU
    while patched version either doesn't consume CPU and doesn't print
    anything or doesn't consume CPU and print 5-10 messages per second
    to the log with verb 4.<br>
    <br>
    <div class=3D"moz-cite-prefix">On 06/11/2016 02:05 PM, Gert Doering
      wrote:<br>
    </div>
    <blockquote cite=3D"mid:20160611110510.GO62247@...1296..."
      type=3D"cite">
      <pre wrap=3D"">Hi,

On Wed, Apr 06, 2016 at 11:44:34PM +0300, ValdikSS wrote:
</pre>
      <pre wrap=3D"">
Coming back to this patch set - could you share your test results?

I'll then go and see that I can code review &amp; merge during the next wee=
k.

gert


</pre>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">------------------------------------------------------=
------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols ar=
e=20
consuming the most bandwidth. Provides multi-vendor support for NetFlow,=20
J-Flow, sFlow and other flows. Make informed decisions using capacity=20
planning reports. <a class=3D"moz-txt-link-freetext" href=3D"https://ad.dou=
bleclick.net/ddm/clk/305295220;132659582;e">https://ad.doubleclick.net/ddm/=
clk/305295220;132659582;e</a></pre>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
Openvpn-devel mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Openvpn-devel@...1466...=
urceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourceforge.net/li=
sts/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/op=
envpn-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------023E0CC6DC379F8736EF3E71--

--rg3csjKADEroMeah8u8UC6RvqFrnm1wew--

--JiMXEqk0v2TiVhA17KkSUCTNivUA8iXqo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIxBAEBCAAbBQJXp2ypFBxpYW1AdmFsZGlrc3Mub3JnLnJ1AAoJEFzXIC7viPdy
n/QP/RneUyMDOS+wPQC0Z179pZqpZkv4N4d2jEDecicrqshfSm1RLttYVZpQ3vlY
sodhqLUhKqmXha+30I3kGOpmoXwSoHXrv8NOiuGUZW6jSdaPYC38HnH/aBDnkb3W
BTQE8YqW04hvEynxCpGbWs/NV2QI2r6fM9I2Vk5wdw1fMebW2aoFKCr2ajlExMrk
7kuU2RJx000Hx0KfjT+5T1YRS1b7Lv+9y7Yv3GmRu74u5yfmrHSf+TKz7S9apxqL
aGRnGBiv/HSGSiWpvvtowS/0HEqPgY93UKEivOxLs+xmp3o2PhzWd1jNkljVC8z+
iYNgtSGGCb1cF80ihsTYt+XkI0JfJ+TTd5XWJTcbxSX6w0bh7aGMOOP0FuR4eaNc
OjkgEypilVqPVnjlqnjgNfpDy2B2CeNk1k1rhFwCHcVqdQw6P6S49A2+8UZVxgJR
MiLQMLl/fPN8k/Eu3lkOcLOK5+MaqxcMZxzRaOLv//+Ms1yAkzM2M4wVOiNLKCoQ
ph1/0fMLDZz8rKMsCsqgRiV7mHfVLJkC3irK1x70I5tMsAJnFleQ37DCXnYmnB5U
YDiHBbPqUYgLqYLvLYv33l4so+k9Fw5XQip2Z1nZvq8CPAUWH0HFR4RVjkdE6Lza
tdrH9CEH/RsCKITQ+gGsM2txXf7X0EPj9s7zJqL3Mz9onu3G
=3c/A
-----END PGP SIGNATURE-----

--JiMXEqk0v2TiVhA17KkSUCTNivUA8iXqo--

