Message-ID: <e45213bd-6aba-02ca-ecb5-fbd51aebe05e@...1227...>
Date: Tue, 7 Feb 2023 12:59:56 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230204004512.250271-2-selva.nair@...277...>
 <20230204064010.257925-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230204064010.257925-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] Build unit tests in mingw
 Windows build
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
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 04.02.23 um 07:40 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> - Minor changes to the build system to include some
>    dependencies for Windows build
> 
> - test_tls_crypt not built as it will pull in win32.c and
>    its dependencies
> 
> - If cross-compiling, "make check" will only build the tests but not
>    run any. Copy to Windows and run manually. Executables are in
>    <buid-dir>/tests/unit_tests/openvpn/.libs/ and these depend on
>    cmocka.dll in addition to openssl libs that some tests link to.
> 
>    Building with mingw on Windows should run the tests (untested).
> 
> v2: networking_testdriver was mistakenly enabled to run, while
> originally it was only set to build. Corrected.
>

I am currently testing this and also trying to add this to the Github 
actions. This patch seems fine but I get other weird errors and cmocka 
builds fine crosscompiling on my own machine but breaks for some reason 
in Github Actions. I am looking into these problems and will give a full 
review after I solved those issues.

Arne


