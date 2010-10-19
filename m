Message-ID: <4CBD3807.8090406@...1420...>
Date: Tue, 19 Oct 2010 08:17:43 +0200
From: Christian Rank <Christian.Rank@...1419...>
MIME-Version: 1.0
References: <mailman.7787.1287437573.5007.openvpn-devel@lists.sourceforge.net>
In-Reply-To: <mailman.7787.1287437573.5007.openvpn-devel@lists.sourceforge.net>
Subject: Re: [Openvpn-devel] Openvpn-devel Digest, Vol 53, Issue 7
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
To: agi@...64...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> Date: Mon, 18 Oct 2010 18:41:39 +0200
> From: Alberto Gonzalez Iniesta <agi@...64...>
> Subject: Re: [Openvpn-devel] Errors adding routes on Windows 7 with
> 	OpenVPN 2.1.3
> To: openvpn-devel@lists.sourceforge.net
> Message-ID: <20101018164138.GB16573@...1330...>
> Content-Type: text/plain; charset=3Diso-8859-1
>=20
> On Mon, Oct 18, 2010 at 05:50:44PM +0200, Christian Rank wrote:
>> Hello,
>>
>> we noticed a strange problem with OpenVPN 2.1.3 on a Windows 7 client
>> here: The VPN tunnel to an OpenVPN server does no longer work since the
>> OpenVPN 2.1.3 software tries to insert many strange routes into the
>> Windows 7 routing tables. With OpenVPN 2.1.1, all goes well. Our OpenVPN
>> server is running on OpenVPN 2.1_rc15 i686-pc-linux-gnu.
>>
>> I have attached the Windows OpenVPN log file (with verbosity 4).
>>
>> Maybe this is a bug in the Windows implementation of OpenVPN 2.1.3?
>>
>=20
> Hi Christian,
>=20
> It's not a bug in the Windows implementation but in OpenVPN 2.1.3
> itself. The bug is reported and it is being worked in.
> I think you're using 'remote_host' on your client configuration (or
> pushing it from the server). If that's the case, try changing that with
> the IP of the VPN server and see if that fixes it in the meantime.

Hi Alberto,

you are right. It was exactly "remote_host" that caused our problem.
After replacing this with the real IP of our VPN gateway, all goes well
again.

Thank you very much for your help.

Best regards,
	Christian

- --=20
Dr. Christian Rank
Rechenzentrum Universit=E4t Passau
Bereich Netzwerk und Telekommunikation
Innstr. 33
D-94032 Passau
GERMANY
Tel.: 0851/509-1838
Fax:  0851/509-1802
PGP public key see http://www.rz.uni-passau.de/mitarbeiter/rank
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iJwEAQECAAYFAky9OAUACgkQICQoVWVVBdW/AwP+I3j2qYBi8N0EaWMeHuEAOFon
HgUXJx4EaD3JdYWHq1iaGT2r8Pvp76wiEtzsiRXSti+K1LebcgzO5qKFG8ffeLQq
FliOx4byYgW6X7hVqINbgJmpZ9n/xCkD2SRMmLiuz5N2d1wj48ZYD9+s/v2msWEg
QRp0/f/3vf+eELDL11A=3D
=3DgLRG
-----END PGP SIGNATURE-----

