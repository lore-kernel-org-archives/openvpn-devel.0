From: Simon Rozman <simon@...2293...>
Date: Mon, 30 Oct 2017 08:41:10 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE108587171C@...2294...>
Content-Language: en-US
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN Interactive Service Branding
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Selva Nair (selva.nair@...277...)" <selva.nair@...277...>, "openvpn-devel (openvpn-devel@lists.sourceforge.net)" <openvpn-devel@lists.sourceforge.net>
Cc: "eduvpn@...321..." <eduvpn@...321...>

Hi Selva,

We are considering distributing a local copy of OpenVPN with eduVPN Client:
- To provide better app isolation;
- To allow eduVPN to manage and update own OpenVPN copy.

The problem is one cannot run two openvpnserv.exe services at the same time=
, because the service control named pipe is hard-coded to "\\.\pipe\openvpn=
\service".

While reviewing the openvpnserv.exe source code, I noticed on the other han=
d, that registry key is configurable as "HKEY_LOCAL_MACHINE\SOFTWARE\<PACKA=
GE_NAME>". Analogous to that, I have created a patch https://github.com/Ame=
bis/openvpn/commit/103f07e54f8c672e1fa220ef197d26692c5d1300 to support "<PA=
CKAGE_NAME>" configuration of named pipes as well.

Along with https://github.com/Amebis/openvpn/commit/082e0c0de2d79ac61cae331=
28d8b35b392fba664 and https://github.com/Amebis/openvpn/commit/9084c4822b83=
ed77b7bedf938acb3d0dd8c3b382 patches to make OpenVPN Administrators group a=
nd OpenVPN firewall rule names configurable as well.

Those three patches provide sufficient way for us to build and run a clone =
of openvpnserv.exe that would not collide with the original one, should use=
r install the original OpenVPN on the same computer.

1. Do you think this commits are appropriate to get merged in the official =
OpenVPN source? (I can deliver git-send-email patches, of course.)

2. We would like to hear your expert opinion about this use-case. Any consi=
derations, drawbacks and like?

Thank you and best regards,
Simon Rozman

