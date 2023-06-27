MIME-Version: 1.0
References: <20230509111205.138997-1-frank@...2641...>
 <20230620135310.94455-1-frank@...2641...>
 <20230620135310.94455-5-frank@...2641...>
In-Reply-To: <20230620135310.94455-5-frank@...2641...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 27 Jun 2023 10:59:48 +0300
Message-ID: <CAGyAFMV=Tyfn0guz2Pq4tR8MVDazSDu0RnPQEzV7_9a-f1PH=Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH 4/5] CMake: Add /Brepro to MSVC link
 options
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

Interesting that MSFT hasn't been able to document this flag for almost 4 y=
ears:

https://developercommunity.visualstudio.com/t/document-brepro-flag/731265

I checked that the flag is indeed passed to the linker command line but hav=
en't
tested that binaries are indeed identical.

Acked-by: Lev Stipakov <lstipakov@...277...>


ti 20. kes=C3=A4k. 2023 klo 16.54 Frank Lichtenheld (frank@...2641...)
kirjoitti:
>
> So that we get reproducible builds.
>
> Change-Id: Iffdd3ac5f266cc7d592ab678afc14c122acbb351
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>  CMakeLists.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index bdbc87b8..3cbba5a3 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -56,6 +56,7 @@ if (MSVC)
>          "$<$<CONFIG:Release>:/Zi>"
>          )
>      add_link_options(
> +        /Brepro
>          "$<$<CONFIG:Release>:/LTCG:incremental>"
>          "$<$<CONFIG:Release>:/DEBUG:FULL>"
>          "$<$<CONFIG:Release>:/OPT:REF>"
> --
> 2.34.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



--=20
-Lev

