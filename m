Date: Thu, 6 Jun 2024 14:43:31 +0000 (UTC)
From: Hannes Domani <ssbssa@...360...>
Message-ID: <1529325337.4434263.1717685011655@...2084...>
In-Reply-To: <202406061133.456BXOgs047085@...2054...>
References: <20240606103441.26598-1-gert@...1296...>
 <202406061133.456BXOgs047085@...2054...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Implement Windows CA
 template match for Crypto-API selector
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, "selva.nair@...277..." <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

 Am Donnerstag, 6. Juni 2024 um 13:34:27 MESZ hat Gert Doering <gert@...1826...=
6...> Folgendes geschrieben:

> Thanks, Selva, for the review.
>
> I have not tested this beyond "does it make GH actions happy",
> "does it build on the local mingw setup" (it does) and "does
> the code look generally safe wrt memory etc" (it does).
>
> As instructed I have removed the "and fallback requested" part
> from the comment where "fallback" was removed from the code.
>
> Your patch has been applied to the master branch.
>
> commit 13ee7f902f18e27b981f8e440facd2e6515c6c83 (master)
> Author: Heiko Wundram
> Date:=C2=A0 Thu Jun 6 12:34:41 2024 +0200
>
>=C2=A0=C2=A0=C2=A0=C2=A0 Implement Windows CA template match for Crypto-AP=
I selector
>
>=C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Heiko Wundram <heiko.wundram@...2375...=
14...>
>=C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Hannes Domani <ssbssa@...360...>
>=C2=A0=C2=A0=C2=A0=C2=A0 Acked-by: Selva Nair <selva.nair@...277...>
>=C2=A0=C2=A0=C2=A0=C2=A0 Message-Id: <20240606103441.26598-1-gert@...1725...=
..>
>=C2=A0=C2=A0=C2=A0=C2=A0 URL: https://www.mail-archive.com/openvpn-devel@...465...=
ists.sourceforge.net/msg28726.html
>=C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Gert Doering <gert@...1296...>

Thanks for pushing this to master.

I wonder if it would be possible to merge this back to 2.6 as well, it's
relatively isolated code, and 2.7 is still far-off (I think).


Regards
Hannes

