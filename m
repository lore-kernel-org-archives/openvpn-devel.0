MIME-Version: 1.0
In-Reply-To: <1323357860-2506-1-git-send-email-davids@...1347...>
References: <1323301588-29815-1-git-send-email-davids@...1347...>
	<1323357860-2506-1-git-send-email-davids@...1347...>
Date: Thu, 8 Dec 2011 22:24:59 +0200
Message-ID: <CAOazyz2rHM0K+m+cZ0_j1OwZc9b5tHYzexpCxRQ9u-tNwNcFhQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3] Move away from openvpn_basename()
 over to platform provided basename()
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

On Thu, Dec 8, 2011 at 5:24 PM, David Sommerseth <davids@...1347...> wrote:
> This kicks out the openvpn_basename() function from misc.[ch] and puts
> glibc equivalents into compat.[ch]. =C2=A0This is to provide the same
> functionality on platforms not having a native basename() function
> available.
>
> In addition this patch adds dirname() which commit 0f2bc0dd92f43c91e
> depends. =C2=A0Without dirname(), openvpn won't build in Visual Studio.
>
> v2: Move all functions from compat.h to compat.c
> v3: Use glibc versions of basename() and dirname() instead
>
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---

Yes, this is valid compat now :)

Alon.

