Message-ID: <4F55EB33.2050907@...515...>
Date: Tue, 06 Mar 2012 12:47:15 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-13-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-13-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 12/52] Update .gitignore
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>


> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  .gitignore |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index 3d12f5d..8cc07de 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -5,6 +5,7 @@
>  *.obj
>  *.pyc
>  *.so
> +*~
>  .deps
>  Makefile
>  Makefile.in

Editor backup files in "git status" are annoying. ACK.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


