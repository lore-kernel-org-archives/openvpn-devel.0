Message-ID: <4FD09CA0.4000608@...1114...>
Date: Thu, 07 Jun 2012 14:20:48 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4FD0735C.7090902@...515...> <CBF6422A.24DA%brabander@...1435...>
	<1CED409804E2164C8104F9E623B08B9012D498A813@...1436...>
	<4FD078F5.7060903@...1543...>
	<20120607102517.GR1059@...1296...>
	<4FD0935A.5050604@...515...>
In-Reply-To: <4FD0935A.5050604@...515...>
Subject: Re: [Openvpn-devel] PolarSSL 1.1.0 support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/06/12 13:41, Samuli Sepp=E4nen wrote:
>=20
>> Hi,
>>=20
>> On Thu, Jun 07, 2012 at 11:48:37AM +0200, Paul Bakker wrote:
>>> Agreed as well..
>> So what...?  1.1.4 or "1.1.0, and put the responsibility on the
>> distro"?
>>=20
> I think this question is related to our project policies, not just
> to PolarSSL support. Do we want to try to protect packagers and
> those building from source from security issues by trying to force
> them to use latest libraries? In practice, some OS/distro packagers
> (e.g. for Debian stable) would have to circumvent our version
> checks due their own project policies.

I probably lean more towards what Alon said earlier in this thread.
We should bother about APIs not which security level/issues each
version have.  Otherwise, we make life miserable for package
maintainers, where they might often backport security fixes without
altering the major/minor version number - which Adriaan also said.

In RHEL the packages are stabilised on a specific version and only
bugfixes and security fixes are backported and only exceptionally
features are backported.  And even more seldom a package rebase
happens.  And then to need to circumvent such version restrictions
when building openvpn, actually makes things harder for users.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/QnKAACgkQDC186MBRfrqadgCfUTrnypxWo56F6W/NmmexSG/z
Ma8An1ZWD4seXjE/f65+NRFUjjXcpEzQ
=3DvRpM
-----END PGP SIGNATURE-----

