MIME-Version: 1.0
References: <1580488320-10224-1-git-send-email-selva.nair@...277...>
 <1581309200-27870-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1581309200-27870-1-git-send-email-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 10 Feb 2020 10:49:13 +0200
Message-ID: <CAGyAFMWNR7gJrh5szv13cJHO-BSqY8MNYmU8JXcnFwia=CZQgg@...278...>
Content-Type: multipart/alternative; boundary="000000000000214ba9059e34d182"
Subject: Re: [Openvpn-devel] [PATCH v3] Swap the order of checks for
 validating interactive service user
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

--000000000000214ba9059e34d182
Content-Type: text/plain; charset="UTF-8"

Built with MSVC and tested, works as described - membership
check is performed only if options validation fails. Also error message
is sent only when user is not authorized (this got broken in v2).

Acked-by: Lev Stipakov <lstipakov@...277...>

--000000000000214ba9059e34d182
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Built with MSVC and=C2=A0tested, works as described -=
 membership</div><div>check is performed only if options validation fails. =
Also error message</div><div>is sent only when user is not authorized (this=
 got broken in v2).</div><div><br></div><div>Acked-by: Lev Stipakov &lt;<a =
href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt;</div></div>

--000000000000214ba9059e34d182--

