Mime-Version: 1.0 (Apple Message framework v1251.1)
From: =?iso-8859-1?Q?Aivo_J=FCrgenson?= <aivo.jurgenson@...277...>
In-Reply-To: <201110171544.37084.heiko.hund@...1489...>
Date: Mon, 17 Oct 2011 17:00:28 +0300
Message-Id: <49FE096B-4F31-4412-B3A6-E62BF6CAA15B@...277...>
References: <5688103A-7248-49C3-9DD8-4CF889DC500F@...277...>
	<4E97E60E.5000408@...515...>
	<201110171544.37084.heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] Management interface doesn't handle PKCS11
	tokens with umlaut characters in the label
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
To: openvpn-devel@lists.sourceforge.net
Cc: James Bekkema <support@...1515...>


On Oct 17, 2011, at 4:44 PM, Heiko Hund wrote:

> Aivo
>=20
> On Friday 14 October 2011 09:34:38 Samuli Sepp=E4nen wrote:
>>> Would it be possible to patch OpenVPN in some way, so that the umlaut
>>> characters doesn't get stripped in the management interface =85 or perh=
aps
>>> there's some other, more robust way of handling such kind of smart-card
>>> authentication?
>>=20
>> James, who is responsible for the management interface, can probably fix
>> this easily.
>=20
> Have you checked with git master. I believe commit=20
> 2627335ac2605d0987a68ce97a0a2c4efbe25159 should have fixed most of the no=
n-
> ASCII charset related problems.

You mean this one?=20
http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn.git;a=
=3Dcommitdiff;h=3D2627335ac2605d0987a68ce97a0a2c4efbe25159

--- a/buffer.c
+++ b/buffer.c
@@ -720,7 +720,7 @@ char_class (const unsigned char c, const unsigned int f=
lags)
     return true;
   if ((flags & CC_DIGIT) && isdigit (c))
     return true;
-  if ((flags & CC_PRINT) && (isprint (c) || c >=3D 0x7f)) /* allow UTF-8 */
+  if ((flags & CC_PRINT) && (c >=3D 32)) /* allow ascii non-control and UT=
F-8 */

Thanks, I will try to compile this and plug this version into the Viscosity=
 client program and see what happens.

--=20
Aivo J=FCrgenson, aivo.jurgenson@...277...


