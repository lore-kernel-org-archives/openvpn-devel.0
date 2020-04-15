Date: Wed, 15 Apr 2020 11:52:50 -0400
From: Nathan Stratton Treadway <nathanst@...1517...>
Message-ID: <20200415155250.GH32337@...1518...>
References: <6a623f26-a30c-eb91-204b-8f938cad2994@...515...>
 <19931d36-6546-75cf-5428-66b235462cd5@...515...>
MIME-Version: 1.0
In-Reply-To: <19931d36-6546-75cf-5428-66b235462cd5@...515...>
Subject: Re: [Openvpn-devel] Summary of the community meeting (15th April
 2020) -- Win installer version checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Wed, Apr 15, 2020 at 13:38:37 +0300, Samuli Sepp=E4nen wrote:
>=20
> Here's the summary of the IRC meeting.
>=20
> ---
>=20
> COMMUNITY MEETING
>=20
> Place: #openvpn-meeting on irc.freenode.net
> Date: Wed 15th April 2020
> Time: 11:30 CEST (09:30 UTC)
>=20
[...]
>=20
> Mattock will check if it would be possible to give unique identifiers to
> Windows 7 and Windows 10 flavors of tap-windows6. This would prevent
> situations where an existing, cached Windows 7 driver is preferred over
> a Windows 10 (attestation signed) version, hence causing driver
> installation failures.
>=20
> Mattock will also check if we could, with a reasonable effort, provide
> users with an easy way to clean up old tap-windows6 drivers in the NSIS
> installer. The process is already known and can be done with external
> scripts, but integration / reimplementation in NSIS is missing.

Just wanted to be sure that the separate-but-related step of having the
Windows installer verify the Windows version at install time is also on
the list for investigation. =20

In our particular case, at least, if the Win7 installer had refused to
proceed when executed under Win10, the situation with TAP driver
mismatch would have been avoided completely.  If it's possible to do,
that seems a preferable outcome, even if the steps mentioned above also
make it much easier to recover from the mismatch situation after the
fact.

(Of course, even better from a user standpoint would be a single unified
OpenVPN Windows installer which automatically installs the
correctly-signed drivers for the current system -- but I assume that
approach has already been investigated/considered earlier in the
development of the Windows installer....)

Thanks.

					Nathan



----------------------------------------------------------------------------
Nathan Stratton Treadway  -  nathanst@...1517...  -  Mid-Atlantic region
Ray Ontko & Co.  -  Software consulting services  -   http://www.ontko.com/
 GPG Key: http://www.ontko.com/~nathanst/gpg_key.txt   ID: 1023D/ECFB6239
 Key fingerprint =3D 6AD8 485E 20B9 5C71 231C  0C32 15F3 ADCD ECFB 6239

