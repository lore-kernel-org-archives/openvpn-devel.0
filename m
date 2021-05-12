From: Matthias May <matthias.may@...2610...>
Message-ID: <c80d31ca-bee5-9194-c288-999754eb709a@...2610...>
Date: Wed, 12 May 2021 22:02:30 +0200
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="y1EHmy1sJmweeDFHpL8yYzMAouJwefc3I"
MIME-Version: 1.0
Subject: [Openvpn-devel] PID is deleted unconditionally on exit
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: gert@...1296..., openvpn-devel@lists.sourceforge.net

--y1EHmy1sJmweeDFHpL8yYzMAouJwefc3I
Content-Type: multipart/mixed; boundary="7ao70Wi0KQKsLkIqhsTyopvKeIE8WlMe5";
 protected-headers="v1"
From: Matthias May <matthias.may@...2610...>
To: gert@...1296..., openvpn-devel@lists.sourceforge.net
Message-ID: <c80d31ca-bee5-9194-c288-999754eb709a@...2610...>
Subject: PID is deleted unconditionally on exit

--7ao70Wi0KQKsLkIqhsTyopvKeIE8WlMe5
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Gert

We recently updated OpenVPN to 2.5.2 and found that the PID
is since [1] unconditionally deleted when OpenVPN exits.
This breaks OpenVPN in our init.
We relied on this file to get the PID to be able to check if the process ac=
tually started,
or something went wrong during init, or to see if the process died sometime=
 later.

One could argue that the absence of the PID file is indication enough that =
the process
doesn't exist anymore, but that doesn't hold up when there are multiple ins=
tances running.

Once the process died we used the PID to look in the syslog for clues as to=
 why the process died,
and present the user with an error message based on that.

Can you please revert this unconditional deletion of the file?
Or do you see any alternative to get the PID of a process that
exits immediately (case of misconfiguration)?

BR
Matthias

[1] https://sourceforge.net/p/openvpn/mailman/message/37055147/




--7ao70Wi0KQKsLkIqhsTyopvKeIE8WlMe5--

--y1EHmy1sJmweeDFHpL8yYzMAouJwefc3I
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQR34wKNh4Jxr+4dJ/3fdrYEUzwNvgUCYJw0VgUDAAAAAAAKCRDfdrYEUzwNvpVx
AQDfsFmACf7r0YcFwLAwFMQXk2Kl0iV+r9chUTS/eQ2IkAEAs6VugLh4+5uXcGmAqV4SJEVW1jAn
ecwpmt1WU51ZBAc=
=x4gN
-----END PGP SIGNATURE-----

--y1EHmy1sJmweeDFHpL8yYzMAouJwefc3I--

