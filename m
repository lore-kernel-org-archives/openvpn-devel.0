MIME-Version: 1.0
References: <1581359742-30511-1-git-send-email-selva.nair@...277...>
 <1581519967-16950-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1581519967-16950-1-git-send-email-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 13 Feb 2020 10:37:02 +0200
Message-ID: <CAGyAFMXnDxQbxXB_igaGi+Muzwx7hMinxyt3VFEK7+xTK1uTeg@...278...>
Content-Type: multipart/alternative; boundary="000000000000e97b3a059e70febb"
Subject: Re: [Openvpn-devel] [PATCH v4 1/2] Skip expired certificates in
 Windows certificate store
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000e97b3a059e70febb
Content-Type: text/plain; charset="UTF-8"

Built and tested with MSVC on Windows 10 - code skips expired certificate
and picks valid one.

Tested that code doesn't explode if --cryptoapicert has unsupported value.

Acked-by: Lev Stipakov <lstipakov@...277...>

--000000000000e97b3a059e70febb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Built and tested with MSVC on Windows 10 =
- code skips expired certificate and picks valid one.<div><br></div><div>Te=
sted that code doesn&#39;t explode if --cryptoapicert has unsupported value=
.</div><div><br></div><div>Acked-by: Lev Stipakov &lt;<a href=3D"mailto:lst=
ipakov@...277...">lstipakov@...277...</a>&gt;</div></div></div>

--000000000000e97b3a059e70febb--

