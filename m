Date: Fri, 17 Jan 2020 16:02:24 -0600
From: Craig Comstock <craig@...2538...>
Message-ID: <20200117220224.GA33346@...2539...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
Subject: [Openvpn-devel] small passwordstore and openvpn cooperation script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I have wanted to integrate my use of password store (https://www.passwordstore.org/) with openvpn
for a while but never quite figured it out. After a conversation on #openvpn I discovered the Management Interface and was able to rather quickly write the script I wanted.

I will be fixing it up for ease of use but the basics here work:

```
sudo /usr/sbin/openvpn --management localhost 7505 \
--management-query-passwords \
--management-hold \
--config $1 >~/.openvpn.log &

MGMT_IFACE=/dev/tcp/localhost/7505

until echo "" > $MGMT_IFACE
do
  sleep 1
done

exec 3> $MGMT_IFACE
echo "hold release" >&3
echo "password Auth '$(pass $2 | head -n1)'" >&3
echo "username Auth $(pass $2 | head -n2 | tail -n1)" >&3
```

$1 is my .ovpn file path
$2 is the path used for pass to retrieve my username/password.
for pass typically password is first line, username is second line in this case.

Thanks,
Craig Comstock | CFEngineer/digger at Northern.tech | personal: unreasonablefarm.org

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEESGo8ZOGtfXSf5OBen4xVY6q84woFAl4iLvAACgkQn4xVY6q8
4wqRUAgAx1L+Rxpiiq8YKWKhsjbzcdM2aYQ2wFW7lqkR1S5Y3JsAoob1Zv4u1eyd
c9dKBzi3dkT10BVkIM/6EysVWzh95xfyWIg6Z7h/fphQT09DlVhX28hRH3wsefTp
VXhTYpBkcpLO6ptJNJIMFwUHl5kP2+91uqo67R2ZRCCp6WUUqicwNGwOJ+/wEinx
BYPJshwzJPXcca97JH1/fgnJqCIMDL46HqNc/g9NgFhYdVIvTHdF+Rgocm1ietsJ
GIL6xa5070Tn4+I471agN4izY7E4+vqC8ie3mXDOyvxtuPKh7UoavWSlLd9nKsox
t4UMiKwY+035gfJ/2AzRFLHZ12Jdgg==
=Cu/E
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--

