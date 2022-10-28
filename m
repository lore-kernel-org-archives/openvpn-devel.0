MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Fri, 28 Oct 2022 10:43:13 -0400
Message-ID: <CAKuzo_hM7yzr3QrYhwL0Gts7F7jEkDZRx3W_whrtBUybmOCMgw@...278...>
Content-Type: multipart/alternative; boundary="000000000000e8ec3205ec194785"
Subject: [Openvpn-devel] 2.5.8 release
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000e8ec3205ec194785
Content-Type: text/plain; charset="UTF-8"

Hi,

If we are releasing a new Windows installer, there are a few new features
in the GUI that could go into the announcement. Unfortunately Changes.rst
in the GUI hasn't been updated since 2015 or so.

The most user visible one are:

(i) OpenVPN 3 support -- the GUI can now work as a user interface for
OpenVPN 3 client
(ii) pkcs11-id-management is now handled -- the GUI can list available
pkcs11-ids and allow the user to select one
(ii) Persistent connections -- the GUI now lists connections started at
boot by the automatic service and lets the user control it. Interactive
inputs such as username/password with such connections are possible.

PLAP support is also in, but it won't be visible to the user until we start
using build scripts from master (i.e., in 2.6).

Regards,

Selva

--000000000000e8ec3205ec194785
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>If we are releasing a new Windows i=
nstaller, there are a few new features in the GUI that could go into the an=
nouncement. Unfortunately Changes.rst in the GUI hasn&#39;t been updated si=
nce 2015 or so.</div><div><br></div><div>The most user visible one are:</di=
v><div>=C2=A0</div><div>(i) OpenVPN 3 support -- the GUI can now work as a =
user interface for OpenVPN 3 client</div><div>(ii) pkcs11-id-management is =
now handled -- the GUI can list available pkcs11-ids and allow the user to =
select one=C2=A0</div><div>(ii) Persistent connections -- the GUI now lists=
 connections started at boot by the automatic service and lets the user con=
trol it. Interactive inputs such as username/password with such connections=
 are possible.</div><div><br></div><div>PLAP support is also in, but it won=
&#39;t be visible to the user until we start using build scripts from maste=
r (i.e., in 2.6).</div><div><br></div><div>Regards,</div><div><br></div><di=
v>Selva</div></div>

--000000000000e8ec3205ec194785--

