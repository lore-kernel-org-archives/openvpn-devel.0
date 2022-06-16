Message-ID: <e01a4857-9dfa-7e47-cb38-4748776c8bde@...515...>
Date: Thu, 16 Jun 2022 10:24:30 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <3363e69c-1788-2ced-e640-8523570b0d8c@...515...>
 <20220605004013.319-1-lstipakov@...277...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
In-Reply-To: <20220605004013.319-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] GitHub Actions: trigger
 openvpn-build GHA on success
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

Acked-by: Samuli Seppänen <samuli@...515...>

Il 05/06/22 03:40, Lev Stipakov ha scritto:
> From: Lev Stipakov <lev@...515...>
> 
> After successfult builds on all platforms,
> start openvpn-build GHA which produces
> Windows MSI installers.
> 
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>   v2:
> 
>    - bring pull_request trigger back
>    - simplify trigger_openvpn_build run condition
> 
>   .github/workflows/build.yaml | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
> index d34f4e9a..6c267a61 100644
> --- a/.github/workflows/build.yaml
> +++ b/.github/workflows/build.yaml
> @@ -1,6 +1,8 @@
>   # The name of our workflow
>   name: Build
> -on: [push, pull_request]
> +on:
> +  push:
> +  pull_request:
>   
>   jobs:
>     checkuncrustify:
> @@ -32,6 +34,7 @@ jobs:
>         - name: Set job status
>           run: test ! -s uncrustify-changes.patch
>           working-directory: openvpn
> +
>     mingw:
>       strategy:
>         fail-fast: false
> @@ -250,7 +253,6 @@ jobs:
>         - name: make check
>           run: make check
>   
> -
>     macos:
>       runs-on: macos-latest
>       strategy:
> @@ -344,3 +346,16 @@ jobs:
>               ${{ matrix.plat }}-Output/${{env.BUILD_CONFIGURATION}}/*.dll
>               ${{ matrix.plat }}-Output/${{env.BUILD_CONFIGURATION}}/*.pdb
>               doc/openvpn.8.html
> +
> +  trigger_openvpn_build:
> +    runs-on: windows-latest
> +    needs: [checkuncrustify, mingw, ubuntu, ubuntu-clang-asan, macos, msvc]
> +    if: ${{ github.event_name != 'pull_request' && github.repository == 'openvpn/openvpn' && github.ref == 'refs/heads/master' }}
> +
> +    steps:
> +    - name: Repository Dispatch
> +      uses: peter-evans/repository-dispatch@...2620...
> +      with:
> +        token: ${{ secrets.OPENVPN_BUILD_REPO_DISPATCH }}
> +        repository: openvpn/openvpn-build
> +        event-type: openvpn-commit

