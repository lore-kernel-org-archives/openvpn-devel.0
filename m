MIME-Version: 1.0
In-Reply-To: <1323301588-29815-1-git-send-email-davids@...1347...>
References: <1323301588-29815-1-git-send-email-davids@...1347...>
Date: Thu, 8 Dec 2011 09:42:17 +0200
Message-ID: <CAOazyz3B=PWg7jySe41p8KTZmWk87H0NM51EvkW1qKC1XPtSXA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Move away from openvpn_basename() over
 to platform provided basename()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Dec 8, 2011 at 1:46 AM, David Sommerseth <davids@...1347...> wrote:
>
> This kicks out the openvpn_basename() function from misc.[ch] andputs
> it into compat.[ch]. =C2=A0This is to provide the same functionality on
> platforms not having a native basename() function available.
>
> In addition this patch adds dirname() which commit 0f2bc0dd92f43c91e
> depends. =C2=A0Without dirname(), openvpn won't build in Visual Studio.
>
> Signed-off-by: David Sommerseth <davids@...1347...>

Hello David,

The idea of compat.[hc] is to have system compatible layer.
There should be no openvpn specific code in these.
Just alternate implementation of missing functionality.
It should be at the end of the chain in term of linkage.

So the "openvpn_dirbasename" should ether be copied to this file and
declared as static or provide a different simpler approach,
(strrchr('\\') or strrchr('/')).

Regards,
Alon.

