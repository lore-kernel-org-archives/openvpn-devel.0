In-Reply-To: <20060823111436.GH29423@...740...>
References: <3141E3B9-C8B1-497D-AF6C-81BEC64E45D7@...739...>
	<20060823111436.GH29423@...740...>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="Apple-Mail-4--195843545"
Message-Id: <A66CDCCE-8899-493D-91B8-6414DEADA612@...739...>
Content-Transfer-Encoding: 7bit
From: Landon Fuller <landonf@...739...>
Date: Wed, 23 Aug 2006 10:01:39 -0700
Subject: Re: [Openvpn-devel] [Openvpn-users] Announcing OpenVPN Auth-LDAP
	2.0-beta2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@...124...>
Cc: openvpn-devel@lists.sourceforge.net, Openvpn-users@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-4--195843545
Content-Type: text/plain; charset="ISO-8859-1"; delsp=yes; format=flowed
Content-Transfer-Encoding: quoted-printable


On Aug 23, 2006, at 04:14, Pasi K=E4rkk=E4inen wrote:

>
> Hi!
>
> Nice work. Need to test it someday..

Thanks.

> Please consider adding a feature which enables administrator to=20=20
> specify
> DNS- and WINS-addresses per group.. that would be really useful to=20=20
> some
> people (like me).

I'd like to be able to specify arbitrary per-group OpenVPN=20=20
configuration options, in a manner similar to the client-config-dir.
The easiest configuration would probably be something like:

<Authorization>
	...
	<Group>
		...
		# OpenVPN Client Configuration
		ClientConfig		/usr/local/etc/openvpn/client/engineering.conf
	</Group>
</Authorization>

In terms of the existing plugin interface, however, this is not=20=20
currently feasible. There is no obvious way for the plugin to return=20=20
a path / setting to the openvpn instance from within=20=20
openvpn_plugin_func_v1().

-landonf


> On Mon, Aug 21, 2006 at 04:07:51PM -0700, Landon Fuller wrote:
>> I'd like to announce the first public beta release of version 2.0 of
>> our LDAP authentication plugin for OpenVPN[1] :
>> 	http://dpw.threerings.net/projects/openvpn-auth-ldap/
>>
>> This release is a vast improvement on the rudimentary 1.0 plugin --
>> new features include:
>> 	- Full support for LDAP search filters -- no more DN templates
>> required.
>> 	- Group-based access control. (rfc2307bis / LDAP)
>> 	- Integration with the OpenBSD Packet Filter. Can add and remove VPN
>> clients to PF tables on connect/disconnect -- even on the basis of
>> group membership. Tested on FreeBSD.
>> 	- Easy to understand Apache-style configuration file.
>>
>> I  hope that this plugin will serve as a solid base for adding
>> additional OpenVPN-specific LDAP features, such as the PF firewall
>> integration.
>>
>> This code should be fairly solid -- it has near 100% unit test
>> coverage, has been subject to full regression testing, and has been
>> rigorously tested for code errors and memory leaks under valgrind.
>> The code also operates flawlessly inside of chrooted OpenVPN
>> instance. We are currently using the module on our production VPN
>> server.
>>
>> Built with the distribution is an independent plugin driver that can
>> be used to test the plugin and your configuration outside of OpenVPN.
>> After you have built the plugin, the driver can be run as follows:
>> 	./src/testplugin <config file>
>>=20=09
>> Cheers,
>> Landon Fuller
>> Three Rings Design, Inc.
>>
>> [1] Version 1.0 of this plugin was hosted on the OpenDarwin website:
>> 	http://www.opendarwin.org/~landonf/software/openvpn-auth-ldap/
>
>


--Apple-Mail-4--195843545
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFE7InzlplZCE/15mMRArsxAJ9vNfe/fKaVEWeG8Jrn0Ahhx05jJQCdF6q8
bOihZuQ12IIP5qh+3qNSXM0=
=eyBx
-----END PGP SIGNATURE-----

--Apple-Mail-4--195843545--

