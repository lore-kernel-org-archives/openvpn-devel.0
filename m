Message-ID: <55530C2A.9090903@...1114...>
Date: Wed, 13 May 2015 10:32:42 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <13470069.462428.1431417550257.JavaMail.root@...1893...>	<5551BE33.2010208@...1227...>	<4001174.479134.1431430060517.JavaMail.root@...1893...>	<CAEsd45ROOw7UBOUTw8T7J_DjiJW-iJ-fo2YyuE5dt9X4VaWyKg@...278...>	<22326556.492960.1431441687378.JavaMail.root@...1893...>	<55526BA8.1060001@...1114...>
	<10228092.9779.1431475516449.JavaMail.root@...1893...>
In-Reply-To: <10228092.9779.1431475516449.JavaMail.root@...1893...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="XDnIRRslNenHRjfJwwlGoriwaclIOkDvD"
Subject: Re: [Openvpn-devel] Request peer review of modified OpenVPN client
 software
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lisa Minogue <lminogue@...1892...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XDnIRRslNenHRjfJwwlGoriwaclIOkDvD
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 13/05/15 02:05, Lisa Minogue wrote:
> Hi David
>=20
>> From: David Sommerseth <openvpn.list@...1114...>
>> Sent: Tue May 12 23:07:52 CEST 2015
>> To: Lisa Minogue <lminogue@...1892...>, Jonathan K. Bullard <jkbullard@...220...=
..277...>
>> Subject: Re: [Openvpn-devel] Request peer review of modified OpenVPN cli=
ent software
>=20
>> The XOR patch which we've basically rejected so far, modifies how
>> OpenVPN packets looks like. Piping the traffic through stunnel will
>> actually encrypt the OpenVPN packets once more, thus the packets will
>> not look like OpenVPN packets. And the same happens if you use obfsproxy
>> from the Tor project, which also is used to mangle the network
>> packets.
>=20
> Briefly what are your reasons for rejecting the XOR patch?

Read carefully below, as I already answered that.

>> We have generally recommended obfsproxy, as that's a tool
>> especially designed to do this clever magic in a very flexible way. So w=
hen a
>> firewall learns the new packet fingerprint, obfsproxy can easily and
>> quickly be extended with another mangler. And that is why we don't want =
this
>> functionality built into OpenVPN. Because it is far harder for
>> OpenVPN to follow what passes through various "Great Firewalls" (you
>> have more countries doing that than just China). The Tor projects have a
>> special interest in making such mangling work as smooth as possible,
>> with great success. Hence that has been our primary recommendation.
>=20
> Thanks once again for your time and effort in helping me understand
> the advantages of using obfsproxy over XOR patch or stunnel4.
>=20
> Do OpenVPN developers have an official wiki on how to use obfsproxy
> with OpenVPN? Or is the article referenced by the following
> URL--https://community.openvpn.net/openvpn/wiki/TrafficObfuscation--your
> official guide?

No, that's the general approach.  Using obfsproxy is actually fairly
simple.  I've not tested the setup which is demonstrated here in a long
time, but I see that nowadays obfsproxy supports a better protocol,
obfs3 instead of obfs2.  And that's the power of obfsproxy, when newer
tweaks are needed to combat these "Great Firewalls", the Tor projects
have a solution for you.


--=20
kind regards,

David Sommerseth


--XDnIRRslNenHRjfJwwlGoriwaclIOkDvD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVTDC0ACgkQDC186MBRfrqumQCfQduyTcNdzCMw21d1D2Zmrd7j
MHsAn2I686RHqQsmiogMeQDh4XRy/Spc
=xYhZ
-----END PGP SIGNATURE-----

--XDnIRRslNenHRjfJwwlGoriwaclIOkDvD--

