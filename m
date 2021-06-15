MIME-Version: 1.0
References: <20210608152434.1403999-1-arne@...1227...>
 <202106090626.1596QtTA086330@...2054...>
In-Reply-To: <202106090626.1596QtTA086330@...2054...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 15 Jun 2021 16:15:49 +0300
Message-ID: <CAGyAFMUDAneQG+_Oqq0aH9jkMeeQNd04+VutEYtxrW5+N43-=w@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add github actions
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
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

This can be safely applied to release/2.5 as well (just did it on my
private repo).

I've just sent the MSVC (msbuild) follow-up:
https://patchwork.openvpn.net/patch/1861/

"Proof" that these two patches work in master:
https://github.com/lstipakov/openvpn/actions/runs/939325710 and
release: https://github.com/lstipakov/openvpn/actions/runs/939359032

ke 9. kes=C3=A4k. 2021 klo 9.28 Gert Doering (gert@...1296...) kirjoitti:
>
> Your patch has been applied to the master branch.
>
> commit b4f658dfb018dcb22962eaa8b45ddd45c55f3003
> Author: Arne Schwabe
> Date:   Tue Jun 8 17:24:34 2021 +0200
>
>      Add github actions
>
>      Signed-off-by: Arne Schwabe <arne@...1227...>
>      Acked-by: Lev Stipakov <lstipakov@...277...>
>      Message-Id: <20210608152434.1403999-1-arne@...1227...>
>      URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg22511.html
>      Signed-off-by: Gert Doering <gert@...1296...>
>
>
> --
> kind regards,
>
> Gert Doering
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



--=20
-Lev

