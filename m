MIME-Version: 1.0
References: <20230331154214.613245-1-frank@...2641...>
 <20230331154214.613245-3-frank@...2641...>
In-Reply-To: <20230331154214.613245-3-frank@...2641...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 31 Mar 2023 18:54:22 +0300
Message-ID: <CAGyAFMXA118DUmDOJdV7M_tAN5mF48pKC7TaFagHY1OkUsdAfw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] vcpkg-ports/pkcs11-helper: Convert
 CONTROL to vcpkg.json
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
> To be in line with current vcpkg packaging policies.
>
> Change-Id: Ifad0965a2b724b0b278783ba9c0ad5a82274445d
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>  .github/workflows/build.yaml                 | 1 +
>  contrib/vcpkg-ports/pkcs11-helper/CONTROL    | 4 ----
>  contrib/vcpkg-ports/pkcs11-helper/vcpkg.json | 7 +++++++
>  3 files changed, 8 insertions(+), 4 deletions(-)
>  delete mode 100644 contrib/vcpkg-ports/pkcs11-helper/CONTROL
>  create mode 100644 contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
>
> diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
> index 0f352dcd..0c16d379 100644
> --- a/.github/workflows/build.yaml
> +++ b/.github/workflows/build.yaml
> @@ -445,6 +445,7 @@ jobs:
>          uses: lukka/run-vcpkg@...2637...
>          with:
>            vcpkgGitCommitId: 'd10d511f25620ca0f315cd83dcef6485efc63010'
> +          vcpkgJsonGlob: '**/openvpn/vcpkg.json'
>            appendedCacheKey: '${{matrix.triplet}}'
>
>        - name: Run MSBuild consuming vcpkg.json
> diff --git a/contrib/vcpkg-ports/pkcs11-helper/CONTROL b/contrib/vcpkg-ports/pkcs11-helper/CONTROL
> deleted file mode 100644
> index 1ead697e..00000000
> --- a/contrib/vcpkg-ports/pkcs11-helper/CONTROL
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -Source: pkcs11-helper
> -Version: 1.29-1
> -Homepage: https://github.com/OpenSC/pkcs11-helper
> -Description: pkcs11-helper is a library that simplifies the interaction with PKCS#11 providers for end-user applications.
> diff --git a/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json b/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
> new file mode 100644
> index 00000000..12f918b7
> --- /dev/null
> +++ b/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
> @@ -0,0 +1,7 @@
> +{
> +    "name": "pkcs11-helper",
> +    "version": "1.29.0",
> +    "description": "pkcs11-helper is a library that simplifies the interaction with PKCS#11 providers for end-user applications.",
> +    "homepage": "https://github.com/OpenSC/pkcs11-helper",
> +    "license": "BSD-3-Clause OR GPL-2.0-only"
> +}
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

