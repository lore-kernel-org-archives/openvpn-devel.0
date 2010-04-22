Message-ID: <4BD082B2.2030406@...1114...>
Date: Thu, 22 Apr 2010 19:09:06 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <7C4973E27A52DB44900D96028C07F413099FC1@...1352...>
In-Reply-To: <7C4973E27A52DB44900D96028C07F413099FC1@...1352...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1.1 and "inactive". "ping" is
 retrigger the inactivity timeout!!
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Siegfried_M=FCller_-_MB_Connect_Line_GmbH?= <mueller@...1351...>
Cc: Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 22/04/10 18:40, Siegfried M=FCller - MB Connect Line GmbH wrote:
> Hi developers,
>=20
> does anyone tried the "inactive" option with the openvpn version 2.1.1?
> I step up from 2.0.1 to 2.1.1 and get the problem, that the client does n=
ot disconnect after inactivity.
> If i set the option "ping 0" instead of "ping 10" the inactivity works. C=
ould that be a problem, that the new version does retrigger the inactivity-=
timeout with his own ping?
> any ideas?
>=20

Having just poked quickly at the code, it seems that "ping 0" disables
the pinging completely.  As a ping packet will cause traffic on the
tunnel, the connection will then not be inactive.  If it worked
differently on OpenVPN 2.0, I can understand you are surprised.

On the other hand, how the code now looks like, this seems to be the
expected behaviour in OpenVPN 2.1.  So using --ping would disable the
- --inactive feature indirectly.

If this was an intended change or not, that I do not know.  But I'll try
to remember to mention it on the developers meeting today.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvQgrIACgkQDC186MBRfro6pgCfQPZWVzZ9mr1dILpcXQ+7AL2Y
jhgAn3YTzamyvddqb2T23qVp0QuSKGt7
=3DmOC3
-----END PGP SIGNATURE-----

