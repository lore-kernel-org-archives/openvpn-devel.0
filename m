Message-ID: <4A109BF1.20809@...41...>
Date: Sun, 17 May 2009 17:21:21 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <49FEBB4E.2060005@...193...>
	<159833601.20090505212153@...449...>	<4A009EB4.2080008@...193...>
	<1366639701.20090505225455@...449...>
In-Reply-To: <1366639701.20090505225455@...449...>
Subject: Re: [Openvpn-devel] version 2.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Cc: openvpn-devel@lists.sourceforge.net

We will be releasing a new Windows GUI for 2.1 that properly uses the
management interface, and can be run by a user without administrator
privileges.  The GUI has already been developed and is available now
with our Access Server product.  We will be open-sourcing this Windows
client GUI as part of the final 2.1 release.

The new GUI is based on the portable WxWidgets library, and carries a
small footprint, so it shouldn't increase the size of the Windows client
installer by very much.

James

Carsten Kr=FCger wrote:
> Hello,
>=20
>> imho keep the current install too (or create 2 different installer) and
>> can add the link.
>=20
> I think it wouldn't be a good idea to propagate openvpn gui for new
> installations. It's dead.
> Who ever like/need openvpn gui can download it from http://openvpn.se/
>=20
> Maybe include both GUIs in the installer and mark openvpn gui as
> deprecated (no default installation).
>=20
> greetings
> Carsten
>=20
>=20
> -------------------------------------------------------------------------=
-----
> The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
> production scanning environment may not be a perfect world - but thanks to
> Kodak, there's a perfect scanner to get the job done! With the NEW KODAK =
i700
> Series Scanner you'll get full speed at 300 dpi even with all image=20
> processing features enabled. http://p.sf.net/sfu/kodak-com
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


