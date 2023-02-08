Message-ID: <a3cf4f5e-292a-0756-a2cc-61c6584371d4@...1227...>
Date: Wed, 8 Feb 2023 12:41:07 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230208001819.244694-3-arne@...1227...>
 <20230208005925.393200-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230208005925.393200-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/3] Build unit tests in mingw
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

Am 08.02.23 um 01:59 schrieb selva.nair@...277...:
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
> v3: exclude check_engine_keys.sh when cross-compiling
> As suggested by Arne Schwabe <arne@...1227...>


Acked-By: Arne Schwabe <arne@...1227...>

Arne


