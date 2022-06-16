Message-ID: <a0301891-d539-dc43-53c6-cf02432f8e01@...515...>
Date: Thu, 16 Jun 2022 09:49:10 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220603080300.182-1-lstipakov@...277...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
In-Reply-To: <20220603080300.182-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] GitHub Actions: trigger openvpn-build
 GHA on success
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

Hi,

Il 03/06/22 11:03, Lev Stipakov ha scritto:
> From: Lev Stipakov <lev@...515...>
> 
> After successfult builds on all platforms,
> start openvpn-build GHA which produces
> Windows MSI installers.
> 
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>   .github/workflows/build.yaml | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
> index d34f4e9a..99968aae 100644
> --- a/.github/workflows/build.yaml
> +++ b/.github/workflows/build.yaml
> @@ -1,6 +1,7 @@
>   # The name of our workflow
>   name: Build
> -on: [push, pull_request]
> +on:
> +  push:

I've understood that this change has no effect, but this is a commonly 
used pattern. So ok with it.

>   
>   jobs:
>     checkuncrustify:
> @@ -32,6 +33,7 @@ jobs:
>         - name: Set job status
>           run: test ! -s uncrustify-changes.patch
>           working-directory: openvpn
> +
>     mingw:
>       strategy:
>         fail-fast: false
> @@ -250,7 +252,6 @@ jobs:
>         - name: make check
>           run: make check
>   
> -
>     macos:
>       runs-on: macos-latest
>       strategy:
> @@ -344,3 +345,19 @@ jobs:
>               ${{ matrix.plat }}-Output/${{env.BUILD_CONFIGURATION}}/*.dll
>               ${{ matrix.plat }}-Output/${{env.BUILD_CONFIGURATION}}/*.pdb
>               doc/openvpn.8.html
> +
> +  trigger_openvpn_build:
> +    runs-on: windows-latest
> +    needs: [checkuncrustify, mingw, ubuntu, ubuntu-clang-asan, macos, msvc]
> +    if: github.ref == 'refs/heads/master'
> +    env:
> +      REPO_DISPATCH: ${{ secrets.OPENVPN_BUILD_REPO_DISPATCH }}
> +
> +    steps:
> +    - name: Repository Dispatch
> +      if: "${{ env.REPO_DISPATCH != '' }}"
> +      uses: peter-evans/repository-dispatch@...2620...
> +      with:
> +        token: ${{ env.REPO_DISPATCH }}
> +        repository: openvpn/openvpn-build
> +        event-type: openvpn-commit

Not having done much with GHA I can't tell if this is correct. But we do 
want this feature and Lev has tested it, so ACK.

Samuli

