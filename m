MIME-Version: 1.0
References: <20230331154214.613245-1-frank@...2641...>
 <20230331154214.613245-4-frank@...2641...>
In-Reply-To: <20230331154214.613245-4-frank@...2641...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 31 Mar 2023 18:54:54 +0300
Message-ID: <CAGyAFMV8ohU5J0Une36rER_mKzxh2FojOKk4cQA6j9L7742TQw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] vcpkg-ports/pkcs11-helper:
 reference upstream PRs in patches
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Reviewed in Gerrit.

Acked-by: Lev Stipakov <lstipakov@...277...>

pe 31. maalisk. 2023 klo 18.43 Frank Lichtenheld
(frank@...2641...) kirjoitti:
>
> So it is easier to check the merge status.
>
> Change-Id: Ia1f8a8d26d4752a7dda1a20521c59ded06bc7c52
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>  ...1-Allow-the-build-to-succeed-if-configured-with-disabl.patch | 2 ++
>  .../vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch   | 2 ++
>  .../pkcs11-helper/pkcs11-helper-002-dynamic_loader_flags.patch  | 2 ++
>  3 files changed, 6 insertions(+)
>
> diff --git a/contrib/vcpkg-ports/pkcs11-helper/0001-Allow-the-build-to-succeed-if-configured-with-disabl.patch b/contrib/vcpkg-ports/pkcs11-helper/0001-Allow-the-build-to-succeed-if-configured-with-disabl.patch
> index 102be4ec..16fa7042 100644
> --- a/contrib/vcpkg-ports/pkcs11-helper/0001-Allow-the-build-to-succeed-if-configured-with-disabl.patch
> +++ b/contrib/vcpkg-ports/pkcs11-helper/0001-Allow-the-build-to-succeed-if-configured-with-disabl.patch
> @@ -12,6 +12,8 @@ Signed-off-by: Frank Lichtenheld <frank@...2641...>
>   lib/Makefile.am | 2 ++
>   2 files changed, 3 insertions(+)
>
> +upstream PR: https://github.com/OpenSC/pkcs11-helper/pull/62
> +
>  diff --git a/configure.ac b/configure.ac
>  index a7e9760..f154ae3 100644
>  --- a/configure.ac
> diff --git a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
> index 84fba080..56e3486e 100644
> --- a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
> +++ b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
> @@ -1,3 +1,5 @@
> +upstream PR: https://github.com/OpenSC/pkcs11-helper/pull/4
> +
>  commit 90590b02085edc3830bdfe0942a46c4e7bf3f1ab (HEAD -> master)
>  Author: David Woodhouse <David.Woodhouse@...753...>
>  Date:   Thu Apr 30 14:58:24 2015 +0100
> diff --git a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_flags.patch b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_flags.patch
> index 325dea8b..6d674581 100644
> --- a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_flags.patch
> +++ b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_flags.patch
> @@ -11,6 +11,8 @@ set original values as defaults, use verbatim (user-supplied) value
>   lib/pkcs11h-core.c                       | 13 +++++++++++--
>   3 files changed, 23 insertions(+), 3 deletions(-)
>
> +upstream PR: https://github.com/OpenSC/pkcs11-helper/pull/59
> +
>  diff --git a/include/pkcs11-helper-1.0/pkcs11h-core.h b/include/pkcs11-helper-1.0/pkcs11h-core.h
>  index 9028c277..56f87718 100644
>  --- a/include/pkcs11-helper-1.0/pkcs11h-core.h
> --
> 2.34.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



-- 
-Lev

