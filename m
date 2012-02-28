Message-ID: <4F4D18C0.1020008@...1114...>
Date: Tue, 28 Feb 2012 19:11:12 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
In-Reply-To: <1848924920.20120228183103@...449...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
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
To: =?ISO-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/02/12 18:31, Carsten Kr=FCger wrote:
> Hello Samuli,
>=20
>> The OpenVPN community project team is proud to release OpenVPN=20
>> 2.3-alpha1. It can be downloaded from here:
>=20
>> <http://openvpn.net/index.php/open-source/downloads.html>
>=20
>> This release includes a few new major features:
>=20
>> * Complete IPv6 support, both transport and payload * Optional
>> PolarSSL support (build time configuration) * Improved plug-in API
>> (v3) which can more easily be expanded in the future: includes
>> support for direct access to X.509 certificate data in plug-ins *
>> Several improvements to the management interface * One-to-one NAT to
>> circumvent IP address conflicts between local and remote networks *
>> New OpenVPN-GUI
>=20
> Are there any chances to get full non-admin support for windows in
> version 2.3 final?
>=20
> I mean strict seperation between OpenVPN service running with local
> system privileges (can modify routes, etc.) and usermode part (command
> line, maybe GUI) that interacts with user (start/stop tunnel, ask for
> passphrase, pin for smartcard, etc.).

This is definitely in the pipe for v2.3.  I don't know how far Heiko have
come on that since last time we discussed it on the #openvpn-devel
channel, but he is really progressing very well here.

The solution we've ended up with is a OpenVPN service helper which runs
some code parts with admin rights and the OpenVPN binary itself
(openvpn.exe) will run completely unprivileged.  Those two instances will
communicate via named pipes, to set up the proper routes and other
networking parameters.

> In companies that have security in mind it's impossible to allow=20
> roadwarriors to connect via openvpn because they would need admin=20
> privileges. Give them only the privilege to start/stop the openvpn
> service didn't help because they can't supply credentials.
>=20
> I'm complaining about this show stoppper for ~4 years :-(
>=20
> I personally like openvpn very much and would like to deploy it for=20
> our users but I've to buy Cisco because the windows client is better.

The time of complaining will come to an end with 2.3 :)  Heiko
demonstrated his prototype at FOSDEM a few weeks ago.  And it really
looked very impressive.  But there are some changes to the openvpn code
base which needs to be applied, in addition to be synced with the GUI
code base.  So we decided to postpone this particular feature to a later
alpha release - instead of postponing the first alpha release even more.
 Just to give Heiko a bit better time to complete his code.  But there
are so many requesting this feature, we really can't ignore it any more.


And Heiko is free to flog me if I've said and/or promised too much :)


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9NGL4ACgkQDC186MBRfrqyBQCePJd6rZ32WeDk09s9xQcNnTTh
J6AAn2vDkemZkTZcou3Mctor47hi+y3W
=3DVlJA
-----END PGP SIGNATURE-----

