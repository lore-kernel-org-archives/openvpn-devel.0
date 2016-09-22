References: <1474538677-23301-1-git-send-email-davids@...515...>
	<CAKuzo_j+FjOCOHMBw5ca1KTPX7AoFwOPkdTRKhLh9yktmFRCwQ@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ddd59c15-8908-f787-c5f1-2f2ca1494a4c@...2080...>
Date: Thu, 22 Sep 2016 19:44:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_j+FjOCOHMBw5ca1KTPX7AoFwOPkdTRKhLh9yktmFRCwQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Have the same username/password length
 regardless of PKCS#11 enablement
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
To: Selva Nair <selva.nair@...277...>, David Sommerseth <davids@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 22/09/16 18:43, Selva Nair wrote:
> Hi,
>=20
> On Thu, Sep 22, 2016 at 6:04 AM, David Sommerseth
> <davids@...515... <mailto:davids@...515...>> wrote:
>=20
> If running an OpenVPN client with --enable-pkcs11 and a server
> without and having a username and/or password with more than 128
> characters, the authentication will fail as the server truncates
> the password to 128 bytes.
>=20
> This makes things easier and more predictable.  Username/passwords=20
> can be up to 4096 bytes, regardless of the --enable-pkcs11 state.
>=20
>=20
> In spite of this change, in most usage scenarios, username,
> password and even pkcs11-id are limited to a much smaller length
> (more like ~256 bytes) for other reasons:
>=20
> The pkcs11-id is the only string that probably needs such a long
> length, but its limited to ~240 bytes when read from the config
> file because of max line length of 256 bytes + 1 for NUL (in some
> code paths 255?). Even if the max line length is increased, the max
> size of an option parameter is 256 bytes (+ 1 for NUL).
>=20
> The 256 byte limit on parameters in response received from
> management (pointed out by Jonathan) is also somewhat related to
> the above: Input from management goes through the same parsing code
> as the lines read from the config file for handling escapes,
> embedded whitespace etc. and a limit of 256 bytes per option
> parameter is imposed
>=20
> Also usernames > 64 bytes will break --username-as-common-name as
> CN is limited to 64 bytes (could 64 code points, but it seems
> openvpn interprets that as 64 bytes).
>=20
> So for most practical purposes, pkcs11-id appears to be limited to
> ~240 bytes characters in the current code. Changing USER_PASS_LEN
> to, say, 256 may be more sensible. That shouldn't break any
> existing configs but may break some use cases where a long id is
> supplied from the command line.

Thank you for a thorough check-up!

I have spotted a few places where 'struct userpass' have been declared
as global variables, like in socks.c, proxy.c and ssl.c.  For
simplicity this can be okay, code wise.  But considering these buffers
is not be used in all configurations (probably not even the majority
of configurations), this seems like wasted memory.  I also do not have
complete overview of the management code yet, as struct user_pass is
used inside some other management related structs, where some might
also be global.

I have no issues to set USER_PASS_LEN to 256 or 1024 or in between as
long as we are confident we don't break anything.  But I think we
could clean up several of these global variables too.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJX5BhuAAoJEIbPlEyWcf3yO8QP/2TJzxlf1nE9XuLZmWuZYLnu
76wUBd+MsPnSGu0Jv8bAqBA2O7kLPH+G6n265x11FLerJk7cbAJqq8j/PXoHP51U
lUSPVuWv2TKdizPjy3zoCxP30YKgvs7mWg4JCyyWvcrC2L/MDLRABFALa7PvhyOQ
OtjIi+9PW5gP3BQ207b1bIXyVCFUgPzlU4V+tE09OXFI2vT7/k+gAkFai0jxI4fb
+6pEhIui3S20CdZlsIUj4jrHWk/bwLPH8JZ7JP+EKxu3XNDN28exP84ngOKjnntt
A/SaKLp2pbtQGeyB1h2Pv07u7vmVwp6bXmxYUhuc6E3POEh1mg+uL2e3Dd3f+2oW
BcZkMN75LpCTQYk3PqwV6UpjJ6jLurTMzAEnQ0Rf6EUFf6Vzeti2QyAoiTynGjGh
zer7lYY918K3+kiFUJ/fvdMhFbnIFcBc3579Hpgahp1V5KhKnGN5t1fnWKAy+7sm
se4pq4Be+SPV/EI6nFvab6dik9MJorSqmWRrfZeTyIV0+3BKtZc8g415litglh6x
gT/Atf4G4BLxe4I3G66flSZBG7rLGi8DZnnsPz2SYcPMQyEz9PbkRA+Dumi7QFRg
i1ghdI6bkT8Fnw3wx4/hHcIr1Tu76xxl6PGKqCp8u3SeXhXv9kzWX29q65Ie1hLB
VNbRKmRCJFMEnV/9g7uG
=3DCjnn
-----END PGP SIGNATURE-----

