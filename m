Message-ID: <53CD0B1B.6000801@...515...>
Date: Mon, 21 Jul 2014 15:44:11 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <11052645.930865.1405935348844.JavaMail.root@...1893...>
	<20140721120346.GL1118@...1296...>
In-Reply-To: <20140721120346.GL1118@...1296...>
Subject: Re: [Openvpn-devel] OpenSSL in OpenVPN software to be replaced?
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
To: Gert Doering <gert@...1296...>, Lisa Minogue <lminogue@...1892...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



> Hi,
>
> On Mon, Jul 21, 2014 at 11:35:48AM +0200, Lisa Minogue wrote:
>> In the light of the above, do you have plans to replace OpenSSL with
PolarSSL or LibreSSL? And how soon will new bundles of OpenVPN software
be released that incorporate OpenSSL alternatives?
> [..]
>> P.S.: I apologize if the above questions have been dealt with in the
past.
>
> Indeed, you could have just googled for "OpenVPN PolarSSL"...
>
> But anyway.  Samuli: can the build environment do windows binaries using
> PolarSSL?  Might be nice to offer both...
>
> gert
>
The build environment for Windows would have to be modified
significantly to support PolarSSL. Although we probably can all agree
that the state of OpenSSL leaves a lot to be desired, it's now funded by
the Core Infratructure Initiative:

<http://www.linuxfoundation.org/programs/core-infrastructure-initiative>

I don't know if money (=3Dfew full-time developers) can save the can of
worms, but probably we should not panic quite yet. Opinions?

- --=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPNCxoACgkQwp2X7RmNIqPLVwCeJlS7jpSFGL8N1UtO/fI17Ovi
C10An3Gzt1blQd5SrCcEE47Qid0oSGin
=3Detcu
-----END PGP SIGNATURE-----


