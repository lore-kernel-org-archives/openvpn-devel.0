From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <29e1d57c-dfa5-ca26-2485-8654a85fdeff@...515...>
Date: Wed, 26 Jul 2017 17:48:24 +0300
MIME-Version: 1.0
Content-Language: en-US
Subject: [Openvpn-devel] Old OpenVPN apt repository key about to expire
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

Hi,

The previous GPG key used to sign our Debian and Ubuntu packages was
bound to expire on 4th August. I extended the lifetime of the key by
three years (26th July 2020).

To prevent apt from complaining after 4th August please do this:

apt-key del E158C569
wget -O - https://swupdate.openvpn.net/repos/repo-public.gpg|\
apt-key add -

More information here:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>

--
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

