From: Jens <openvpn-devel@...2127...>
Message-Id: <B32C1FDE-D0CF-49A7-A231-28267BB89B46@...2127...>
Date: Tue, 19 Apr 2016 21:01:32 +0200
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: [Openvpn-devel] [PATCH] auth-pam:Fix buffer overflow by user
	supplied data
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

Hi,

please review the following patch.

The AUTH-PAM plugin contains the function `searchandreplace`. The buffer al=
located there can be overflown if the parameter `replace_with`  is to long =
(depending on the format string).

E.g.:

 searchandreplace(to search :=3D=E2=80=9CX=E2=80=9D, searchfor :=3D =E2=80=
=9CX=E2=80=9D, replacewith :=3D =E2=80=9C0123456789!=E2=80=9D)

would overflow `temp` with the character =E2=80=98!=E2=80=99.

The call tree contains multiple calls with a user supplied value for `repla=
ce_with`.

Jens

