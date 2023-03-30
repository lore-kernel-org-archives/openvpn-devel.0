MIME-Version: 1.0
References: <20230330101536.533080-1-frank@...2641...>
In-Reply-To: <20230330101536.533080-1-frank@...2641...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 30 Mar 2023 13:43:38 +0300
Message-ID: <CAGyAFMWxV14qRLj95e06Sd0PsT64b5__UsFjcSGpmHQTK73Esw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] vcpkg: request "tools" feature of
 openssl for MSVC build
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

GHA seems happy about this change:
https://github.com/flichtenheld/openvpn/actions/runs/4562871750/jobs/8050638911

Acked-by: Lev Stipakov <lstipakov@...277...>

to 30. maalisk. 2023 klo 13.17 Frank Lichtenheld
(frank@...2641...) kirjoitti:
>
> We need this for the MSI build. Previously this was enabled
> by default.
>
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>  .github/workflows/build.yaml | 2 +-
>  src/openvpn/vcpkg.json       | 5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
> index 99ae437e..4766efdc 100644
> --- a/.github/workflows/build.yaml
> +++ b/.github/workflows/build.yaml
> @@ -440,7 +440,7 @@ jobs:
>        - name: Restore artifacts, or setup vcpkg (do not install any package)
>          uses: lukka/run-vcpkg@...2637...
>          with:
> -          vcpkgGitCommitId: 'cafd398be781144787573ca78390e951673c7055'
> +          vcpkgGitCommitId: 'd10d511f25620ca0f315cd83dcef6485efc63010'
>            appendedCacheKey: '${{matrix.triplet}}'
>
>        - name: Run MSBuild consuming vcpkg.json
> diff --git a/src/openvpn/vcpkg.json b/src/openvpn/vcpkg.json
> index 80645677..0afd802c 100644
> --- a/src/openvpn/vcpkg.json
> +++ b/src/openvpn/vcpkg.json
> @@ -3,7 +3,10 @@
>    "name": "openvpn",
>    "version": "2.6",
>    "dependencies": [
> -    "openssl",
> +     {
> +       "name": "openssl",
> +       "features": ["tools"]
> +     },
>      "tap-windows6",
>      "lzo",
>      "lz4",
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

