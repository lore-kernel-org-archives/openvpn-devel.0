Message-ID: <4E5DFF88.70701@...1114...>
Date: Wed, 31 Aug 2011 11:31:52 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4E4B873F.6080009@...515...>	<1313652334-15914-1-git-send-email-samuli@...515...>	<4E575276.80206@...1114...>
	<4E576922.8010209@...515...>	<jwvty94e087.fsf-monnier+INBOX@...1269...>	<20110829140648.GU8496@...1296...>
	<4E5DCD83.9080507@...515...>
In-Reply-To: <4E5DCD83.9080507@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Added whitespace handling for
 $KEY_CONFIG variable in easy-rsa/2.0/vars
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 31/08/11 07:58, Samuli Sepp=E4nen wrote:
>=20
>> Hi,
>>
>> On Fri, Aug 26, 2011 at 10:07:00AM -0400, Stefan Monnier wrote:
>>> POSIX mandates $() so any posix shell will support it.  The issue is
>>> with non-POSIX shells, if you do want to support them (e.g. Solaris's
>>> /bin/sh).
>> I'd rather not go down that rat-hole.  Even Solaris has POSIX-compliant
>> shells today (ISTR that there is /bin/ksh).
>>
>> gert
> Perhaps this is simply a documentation issue:
>=20
> "Please use a POSIX-compliant shell (e.g. dash) with easy-rsa or you may
> get unexpected results. For example, /bin/sh on Solaris is not
> compliant, but you can use /bin/ksh instead."
>=20
> What do you think?

ACK!  That makes sense to me.  But it needs to be clearly visible in some
kind of requirements list.  If we don't have that, that's probably
something we should have.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk5d/4YACgkQDC186MBRfrohGACgoQFXyVf3n653bcAfNgPKssg0
K4MAnjYSnGkMxY1Fa64sNqR1MSU6B7L0
=3DtpDb
-----END PGP SIGNATURE-----

