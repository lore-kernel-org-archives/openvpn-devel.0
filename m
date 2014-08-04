Message-ID: <53DF208D.20408@...1790...>
Date: Mon, 04 Aug 2014 07:56:29 +0200
From: Tore Anderson <tore@...1790...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Debian/Ubuntu repo PGP key has expired
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
To: openvpn-devel@lists.sourceforge.net

Good morning,

FYI, it appears that the PGP key used to sign the Debian/Ubuntu binaries
available at
https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos has
expired. This causes APT to warn about invalid signatures whenever it's
being run.

$ curl -s https://swupdate.openvpn.net/repos/repo-public.gpg  | gpg --import
gpg: key E158C569: public key "Samuli Sepp=E4nen (OpenVPN Technologies, Inc=
) <samuli@...515...>" imported
gpg: Total number processed: 1
gpg:               imported: 1  (RSA: 1)
$ gpg --list-key E158C569
pub   2048R/E158C569 2011-08-03 [expired: 2014-08-02]
uid                  Samuli Sepp=E4nen (OpenVPN Technologies, Inc) <samuli@=
...515...>

Tore

