References: <20190815072855.21232-1-fkooman@...2318...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <aca20c96-e81b-19b7-beec-631e165868f8@...2080...>
Date: Thu, 15 Aug 2019 14:31:14 +0200
MIME-Version: 1.0
In-Reply-To: <20190815072855.21232-1-fkooman@...2318...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="bt9mcRg8somMIUS1mbGgyXYLykG54lJid"
Subject: Re: [Openvpn-devel] [PATCH] More specific syslog process name with
 systemd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bt9mcRg8somMIUS1mbGgyXYLykG54lJid
Content-Type: multipart/mixed; boundary="IsZKCfJ3W9iqy9ayiAWWt6GWx4KSagL6v";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <aca20c96-e81b-19b7-beec-631e165868f8@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] More specific syslog process name with
 systemd
References: <20190815072855.21232-1-fkooman@...2318...>
In-Reply-To: <20190815072855.21232-1-fkooman@...2318...>

--IsZKCfJ3W9iqy9ayiAWWt6GWx4KSagL6v
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 15/08/2019 09:28, Fran=C3=A7ois Kooman wrote:
> Adds the `--syslog` option to specify the unit and configuration
> name when using systemd.

Could you please provide a rationale to why this is needed?  How things wor=
ks
now, is that the systemd-journal picks up everything; including various
additional meta-data which syslog does not support.

Now you get the log data with: `journalctl -u openvpn-{client,server}@CONFI=
G}`
And this also provides filtering possibilities as well, like '-b' (only log
entries since last boot) or '--since yesterday'.

If you want logged data to syslog, have a look at the journal integration
rsyslog provides - which can also include the additional meta-data:
<https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/h=
tml/system_administrators_guide/s1-interaction_of_rsyslog_and_journal>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--IsZKCfJ3W9iqy9ayiAWWt6GWx4KSagL6v--

--bt9mcRg8somMIUS1mbGgyXYLykG54lJid
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJdVVCYAAoJEIbPlEyWcf3yxJcP/0zzBVjC8g9aAnAowibsv3k1
YjmsITRXy6S2//GYUs8FSvC+peDRmfdujal+oivMNGFJ0Py193CMYKvOm/pqI+F0
T3ZE+OxlG3eCD9mvYsXeVregp7rkJVcxGJq1mPh9ycTatGVvn7DLYei4w7w0bZKe
8TAdbb4eUFCqXKEt0M2AEIyUzSeAwbAtpni4hNV7ToKLhxnw4uaSycyozCfR+IsX
a2vkjIfHCFDzuwbtMwYAiVbZIYLx+m+Ni2+U9hIby55CkTl6Mz9WsmMKY35qxPc+
yLfPzOfK1ldV4jqfJh2zOYOwCQ0NX1oL+rZCp9URfAJ1Fv8D21lGy8is3Adktuhe
pyZk6+hhEm+vqYTQlx+cDF70s2aOm+lHGjMVsXqLdW1+mtxwpoln5fcOhWUISRbY
i4F62Tb6eRzcEXi4QyajCxvq54PHBNRbIE66/YViv6twNP17E3c3aq8sHE/yi4cV
r6uOBOJjwCBD8aNUGF2/WsU08IYlsIVsPQfJURLMyPRcGWfL3ScLJy3K3OzGroDY
9U/Jsgb4R/eZn4HATrWULTUkJqB3P7Ms2H4rD/fVjrUUzow5Jaf2AFdlYv12B2iB
AoBzVEq5NOJCnOq1NeOWDkDZd9P8darX3CHJUVxSjer8PnVY6W08ypJ167ylxZbT
FJFE63fLHB533g8gxKpt
=/gMS
-----END PGP SIGNATURE-----

--bt9mcRg8somMIUS1mbGgyXYLykG54lJid--

