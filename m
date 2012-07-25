MIME-Version: 1.0
Date: Wed, 25 Jul 2012 13:57:20 +0800
Message-ID: <CAO5YuCUbSojNT5m78QChRjTr=f4JHkiAA-P7+sa62RA5KVyHog@...278...>
From: jay alco <jproxy22@...277...>
Content-Type: multipart/alternative; boundary=047d7b10cdf9f2caf504c5a1269c
Subject: [Openvpn-devel] enable P2MP opentions?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--047d7b10cdf9f2caf504c5a1269c
Content-Type: text/plain; charset=ISO-8859-1

Hi, i build openvpn from source with the following featured disabled SSL,
CRYPTO. I have successfully build openpn without this option but during the
test running the server configuration it gives me error

Options error: Unrecognized option or missing parameter(s) in
config.ovpn:6: client-cert-not-required (2.2.2)

i user the following options.

local xxx.xxx.xxx.xxx
port 800
proto tcp
dev tun

client-cert-not-required
script-security 2
username-as-common-name
plugin /usr/share/openvpn/plugin/lib/openvpn-auth-pam.so /etc/pam.d/login
server 10.10.0.0 255.255.255.0
persist-key
persist-tun


It looks like all options under P2MP and P2MP_SERVER are disable when i
disable SSL, CRYPTO. and for that i can not use client-cert-not-required,
username-as-common-name, server X X, etc.. and cannot run the server. How
do i eneable P2MP and P2MP_SERVER during build?

--047d7b10cdf9f2caf504c5a1269c
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi, i build openvpn from source with the following featured disabled SSL, C=
RYPTO. I have successfully build openpn without this option but during the =
test running the server configuration it gives me error<br><br>Options erro=
r: Unrecognized option or missing parameter(s) in config.ovpn:6: client-cer=
t-not-required (2.2.2)<br>
<br>i user the following options.<br><br>local xxx.xxx.xxx.xxx<br>port 800<=
br>proto tcp<br>dev tun<br><br>client-cert-not-required<br>script-security =
2<br>username-as-common-name<br>plugin /usr/share/openvpn/plugin/lib/openvp=
n-auth-pam.so /etc/pam.d/login<br>
server 10.10.0.0 255.255.255.0<br>persist-key<br>persist-tun<br><br><br>It =
looks like all options under P2MP and P2MP_SERVER are disable when i disabl=
e SSL, CRYPTO. and for that i can not use client-cert-not-required, usernam=
e-as-common-name, server X X, etc.. and cannot run the server. How do i ene=
able P2MP and P2MP_SERVER during build?<br>

--047d7b10cdf9f2caf504c5a1269c--

