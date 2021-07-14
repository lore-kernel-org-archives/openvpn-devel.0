Reply-To: openvpn-devel@lists.sourceforge.net
From: David Sommerseth <openvpn@...2080...>
Message-ID: <6cd395fa-2519-6a20-7657-a72bc4469d63@...2080...>
Date: Wed, 14 Jul 2021 12:09:20 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UHlL4GfKA0TmZ2XrjpDXYrLDMyZBNqYMD"
Subject: [Openvpn-devel] OpenVPN 3 Linux client - v15 beta released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UHlL4GfKA0TmZ2XrjpDXYrLDMyZBNqYMD
Content-Type: multipart/mixed; boundary="snd5HcapcReeIqLEH0JpUAzj6ypPVujMO";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: openvpn-devel@lists.sourceforge.net
Message-ID: <6cd395fa-2519-6a20-7657-a72bc4469d63@...2080...>
Subject: OpenVPN 3 Linux client - v15 beta released

--snd5HcapcReeIqLEH0JpUAzj6ypPVujMO
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable


Hi,

The OpenVPN 3 Linux v15 (beta) is now available.  This is primarily
a bugfix release as a few issues appeared soon after the last release.

* Bugfix: 2FA authentication with dynamic challenge protocol

   Servers (most commonly OpenVPN Access Server) deployed with 2FA
   based authentication would fail when the dynamic challenge protocol
   was utilized.  The result would be a client disconnecting with a
   time-out error and in some cases the openvpn3 sessions-list' would
   enlist "ghost" sessions not responding.  This command would also
   wait for a long time before reporting the complete list of sessions
   when such ghost sessions are present.  This is fixed.

   Reported: <https://github.com/OpenVPN/openvpn3-linux/issues/55>

* Bugfix: Fix misbehaviours with --tls-crypt-v2

   This feature has been a known issue for a long time, but newer
   OpenVPN Access Servers now pushes tls-crypt-v2 profiles resulting
   in connections failing with NETWORK_EOF_ERROR errors in the log.
   This is finally fixed.

   Reported: <https://github.com/OpenVPN/openvpn3-linux/issues/55>

* Feature: Added openvpn3-admin variables command

   This "openvpn3-admin variables" command will provide runtime
   information used by openvpn3-linux.  First variable accessible
   is the value reported in the IV_HWADDR field sent to the VPN
   server.  This can be seen using:

      # openvpn3-admin variables --machine-id

Supported Linux distributions:

   - Debian 9 (amd64)
   - Debian 10 (amd64, arm64)
   - CentOS 7 (x86_64)
   - CentOS 8 (x86_64, aarch64)
   - Fedora 33, 34 and Rawhide (x86_64, aarch64, s390x)
   - Red Hat Enterprise Linux 7 (x86_64)
   - Red Hat Enterprise Linux 8 (x86_64, aarch64)
   - Ubuntu 16.04 (amd64)
   - Ubuntu 18.04, 20.04, 20.10 and 21.04 (amd64, arm64)

The arm64 support on selected Debian and Ubuntu releases are
currently considered a tech-preview.

The Data Channel Offload (DCO) tech-preview feature is supported
in these distributions:

   - CentOS 8
   - Fedora 33, 34 and Rawhide
   - Ubuntu 20.04, 20.10 and 21.04
   - Red Hat Enterprise Linux 8

Remember to update the kmod-ovpn-dco package to the latest
available version.

Instructions how to install OpenVPN 3 Linux can be found here:
<https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux>


--=20
kind regards,

David Sommerseth
OpenVPN Inc


---- Source tarballs ---------------------------------------------------

* OpenVPN 3 Linux v15 beta

   <https://swupdate.openvpn.net/community/releases/openvpn3-linux-15_beta.=
tar.xz>
   <https://swupdate.openvpn.net/community/releases/openvpn3-linux-15_beta.=
tar.xz.asc>

---- SHA256 Checksums --------------------------------------------------

86a29c6cc8bc4dfa15aa913f696e048989ebf682bbc184ae050f61256f87e37f  openvpn3-=
linux-15_beta.tar.xz
be0fedded031a135ae2fe82edcac742b5352d17d16648643328b247476953c0f  openvpn3-=
linux-15_beta.tar.xz.asc

---- git references ----------------------------------------------------

git repositories:
     <https://gitlab.com/openvpn/openvpn3-linux>
     <https://github.com/OpenVPN/openvpn3-linux>

git tag: v15_beta
git commit: 6c9bbc9e10d7c499339c1ac774d1614e8df88573

---- Changes from v14 to v15 -------------------------------------------

David Sommerseth (5):
       docs: Update README.md with new DCO and SELinux info
       common: Extend MachineID to provide source information
       ovpn3cli/admin: Add a new 'variables' admin command
       Revert "client/core: Improve fatal exception handling in event()"
       core-ext: Add support for inline --tls-crypt-v2

------------------------------------------------------------------------



--snd5HcapcReeIqLEH0JpUAzj6ypPVujMO--

--UHlL4GfKA0TmZ2XrjpDXYrLDMyZBNqYMD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmDut9EACgkQhs+UTJZx
/fKceRAApUabhhWtcdqvmI96F3OMv4JOoZ/2wnKnftQrDcycs17YFsn2bHXKICAV
FWKOgG0DBjYvKnWFLknIH/wKrQMnG3OvaoUAqXYmSOwZwjfFvcHgLu6yD+5Gtae4
m0385TVzVkQYTTyLQIyVGzITcRTvDG61nmJij6emIdMhCp8a3b4pee0gRAJhPzir
CPW9IqfHlYc9e9ASz5S4IfmrK7jiPZphRoGd5Fur97UNVn8QEgZGaITlDUBHHsD3
iUFDsmm3iF3efeChCHJx2iuZo13hDBKJCBoTH4X0K42KHubNFa3lTpvHqnD2/+Cl
1/meFm9CtmixoX+/o5clU5lQZ0E8rvhBYLQNYow2oZkxtcSqtPJKbRLWhFiVDsVB
LfLUfBwUjDPb75LOAAwVJilIyPit2XjM8T2GFOG+rVJGVEVzxAAgW+K1gChQY81S
O05zaE7h9uGcMm7syEds8S+hGqt7d+UF/VU+XNwwnr/DkZzFy8k6+ShhcEmNjyKq
yDgKddAaopXCAaJ+52Me5c1wnylxFc95rfQc6tR8ZJiGzXgbBMdrXEkwnAvAUYIP
6tg4a99QDj8y+HQXM/Ol2JGDbQfjjsHZnRwHyThD9epGdOcwEhlYS5+JV8CWkX1K
+QsdYSriatewMN6LKti3V6bq+d/A4lD16908E3LhxZKhFUTWvfE=
=44TA
-----END PGP SIGNATURE-----

--UHlL4GfKA0TmZ2XrjpDXYrLDMyZBNqYMD--

