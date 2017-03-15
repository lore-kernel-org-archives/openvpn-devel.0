References: <1b2fc2aa-74b0-6a91-aeb0-a45d7a8062cc@...1918...>
	<20170315210046.GW93896@...1296...>
From: Eric Thorpe <eric@...1918...>
Message-ID: <df273b9b-6ca4-a539-cdf5-d4f9f991896b@...1918...>
Date: Thu, 16 Mar 2017 09:40:31 +1100
MIME-Version: 1.0
In-Reply-To: <20170315210046.GW93896@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix Building Using MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

Patch below with the requested hunks removed.

Signed-off by: Eric Thorpe <eric@...1918...>

diff --git a/config-msvc-version.h.in b/config-msvc-version.h.in
index 4bc89e7..7977cb8 100644
--- a/config-msvc-version.h.in
+++ b/config-msvc-version.h.in
@@ -1,8 +1,12 @@
  #define PACKAGE_NAME "@PRODUCT_NAME@"
-#define PACKAGE_STRING "@PRODUCT_NAME@ @PRODUCT_VERSION@"
+#define PACKAGE_STRING "@PRODUCT_NAME@ 
@PRODUCT_VERSION_MAJOR@...220...@PRODUCT_VERSION_MINOR@@PRODUCT_VERSION_PATCH@"
  #define PACKAGE_TARNAME "@PRODUCT_TARNAME@"
  #define PACKAGE "@PRODUCT_TARNAME@"
-#define PACKAGE_VERSION "@PRODUCT_VERSION@"
+#define PRODUCT_VERSION_MAJOR "@PRODUCT_VERSION_MAJOR@"
+#define PRODUCT_VERSION_MINOR "@PRODUCT_VERSION_MINOR@"
+#define PRODUCT_VERSION_PATCH "@PRODUCT_VERSION_PATCH@"
+#define PACKAGE_VERSION 
"@PRODUCT_VERSION_MAJOR@...220...@PRODUCT_VERSION_MINOR@...220...@PRODUCT_VERSION_PATCH@"
+#define PRODUCT_VERSION 
"@PRODUCT_VERSION_MAJOR@...220...@PRODUCT_VERSION_MINOR@...220...@PRODUCT_VERSION_PATCH@"
  #define PRODUCT_BUGREPORT "@PRODUCT_BUGREPORT@"
  #define OPENVPN_VERSION_RESOURCE @PRODUCT_VERSION_RESOURCE@
  #define TAP_WIN_COMPONENT_ID "@PRODUCT_TAP_WIN_COMPONENT_ID@"
diff --git a/config-msvc.h b/config-msvc.h
index 3e71c85..9b97e71 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -126,6 +126,7 @@ typedef __int64 int64_t;
  typedef __int32 int32_t;
  typedef __int16 int16_t;
  typedef __int8 int8_t;
+typedef uint16_t in_port_t;

  #ifdef HAVE_CONFIG_MSVC_LOCAL_H
  #include <config-msvc-local.h>
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 8dfbea5..e8a48e2 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -99,13 +99,16 @@
      </Link>
    </ItemDefinitionGroup>
    <ItemGroup>
+    <ClCompile Include="argv.c" />
      <ClCompile Include="base64.c" />
+    <ClCompile Include="block_dns.c" />
      <ClCompile Include="buffer.c" />
      <ClCompile Include="clinat.c" />
      <ClCompile Include="comp-lz4.c" />
      <ClCompile Include="comp.c" />
      <ClCompile Include="compstub.c" />
      <ClCompile Include="console.c" />
+    <ClCompile Include="console_builtin.c" />
      <ClCompile Include="crypto.c" />
      <ClCompile Include="crypto_openssl.c" />
      <ClCompile Include="cryptoapi.c" />
@@ -164,12 +167,15 @@
      <ClCompile Include="ssl_verify.c" />
      <ClCompile Include="ssl_verify_openssl.c" />
      <ClCompile Include="status.c" />
+    <ClCompile Include="tls_crypt.c" />
      <ClCompile Include="tun.c" />
      <ClCompile Include="win32.c" />
    </ItemGroup>
    <ItemGroup>
+    <ClInclude Include="argv.h" />
      <ClInclude Include="base64.h" />
      <ClInclude Include="basic.h" />
+    <ClInclude Include="block_dns.h" />
      <ClInclude Include="buffer.h" />
      <ClInclude Include="circ_list.h" />
      <ClInclude Include="clinat.h" />
@@ -249,6 +255,7 @@
      <ClInclude Include="ssl_verify_openssl.h" />
      <ClInclude Include="status.h" />
      <ClInclude Include="syshead.h" />
+    <ClInclude Include="tls_crypt.h" />
      <ClInclude Include="tun.h" />
      <ClInclude Include="win32.h" />
    </ItemGroup>
@@ -268,4 +275,4 @@
    <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
    <ImportGroup Label="ExtensionTargets">
    </ImportGroup>
-</Project>
+</Project>
\ No newline at end of file
diff --git a/src/openvpn/openvpn.vcxproj.filters 
b/src/openvpn/openvpn.vcxproj.filters
index 8b6a269..30df5ec 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -216,6 +216,18 @@
      <ClCompile Include="comp-lz4.c">
        <Filter>Source Files</Filter>
      </ClCompile>
+    <ClCompile Include="argv.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="block_dns.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="console_builtin.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="tls_crypt.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
    </ItemGroup>
    <ItemGroup>
      <ClInclude Include="base64.h">
@@ -464,10 +476,22 @@
      <ClInclude Include="win32.h">
        <Filter>Header Files</Filter>
      </ClInclude>
+    <ClInclude Include="compstub.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="argv.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="block_dns.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="tls_crypt.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
    </ItemGroup>
    <ItemGroup>
      <ResourceCompile Include="openvpn_win32_resources.rc">
        <Filter>Resource Files</Filter>
      </ResourceCompile>
    </ItemGroup>
-</Project>
+</Project>
\ No newline at end of file

On 16/03/2017 8:00 AM, Gert Doering wrote:
> Hi,
>
> thanks for your patch.  I'm not exactly happy with it for a number
> of reasons, but it's a good way to get started.
>
> Details...
>
> On Tue, Mar 14, 2017 at 09:26:52AM +1100, Eric Thorpe wrote:
> [..]
>> diff --git a/config-msvc-version.h.in b/config-msvc-version.h.in
>> index 4bc89e7..7977cb8 100644
>> --- a/config-msvc-version.h.in
>> +++ b/config-msvc-version.h.in
> I can't comment on these changes, but I assume that's "funny macro handling"
> related...  and since it's MSVC only, the risk of breaking anything else
> is small.
>
>> diff --git a/config-msvc.h b/config-msvc.h
>> index 3e71c85..9b97e71 100644
>> --- a/config-msvc.h
>> +++ b/config-msvc.h
>> @@ -126,6 +126,7 @@ typedef __int64 int64_t;
>>    typedef __int32 int32_t;
>>    typedef __int16 int16_t;
>>    typedef __int8 int8_t;
>> +typedef uint16_t in_port_t;
> The indenting of that chunk looks a bit weird (extra space at the
> beginning of the context lines) but that's easily sorted manually.
>
>
>>    #ifdef HAVE_CONFIG_MSVC_LOCAL_H
>>    #include <config-msvc-local.h>
>> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
>> index 5549d70..bed39f3 100644
>> --- a/src/openvpn/crypto_openssl.c
>> +++ b/src/openvpn/crypto_openssl.c
>> @@ -287,7 +287,12 @@ show_available_ciphers()
>>
>>        /* If we ever exceed this, we must be more selective */
>>        const size_t cipher_list_len = 1000;
>> +#ifdef _MSC_VER
>> +    //While GCC will allow you to use a const, MSVC won't (at least
>> with a simple declaration). Use a compile time constant for now
>> +    const EVP_CIPHER *cipher_list[1000];
>> +#else
>>        const EVP_CIPHER *cipher_list[cipher_list_len];
>> +#endif
>>        size_t num_ciphers = 0;
> I don't think we should do this.  If we have a length, use it.  If
> the compiler is too daft to understand consts, maybe we should go
> for "#define CIPHER_LIST_LEN 1000" instead - indeed, more changes,
> but no magic numbers.  Or abandon the definition, use [1000], and
> sizeof() in the out of bounds check below.
>
> Steffan, your code, what would you say?
>
>
> Style-wise: please do not use C++ comments, and break long lines.
>
>
>> --- a/src/openvpn/openvpn.vcxproj
>> +++ b/src/openvpn/openvpn.vcxproj
>> @@ -99,13 +99,16 @@
>>        </Link>
>>      </ItemDefinitionGroup>
>>      <ItemGroup>
>> +    <ClCompile Include="argv.c" />
>>        <ClCompile Include="base64.c" />
>> +    <ClCompile Include="block_dns.c" />
> Yeah.  Oversight when we added new modules - these are easy enough :-)
>
>> diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
>> index c64c65f..a974e7e 100644
>> --- a/src/openvpn/ssl_openssl.h
>> +++ b/src/openvpn/ssl_openssl.h
>> @@ -49,7 +49,11 @@
>>     */
>>    struct tls_root_ctx {
>>        SSL_CTX *ctx;
>> +#ifdef _MSC_VER
>> +    struct timeval crl_last_mtime;
>> +#else
>>        struct timespec crl_last_mtime;
>> +#endif
>>        off_t crl_last_size;
>>    };
> We should not do this.  It's not your fault for finding this, but having
> looked at the code to understand why this would be fixing things, I
> wonder why we're using a "struct timespec" in the first place, or
> why we're having a structure "with subseconds" in there when all we use
> is the "seconds" bit *because* "windows has no nanoseconds"...
>
> src/openvpn/ssl.c
>
>      /*
>       * Store the CRL if this is the first time or if the file was changed since
>       * the last load.
>       * Note: Windows does not support tv_nsec.
>       */
>      if ((ssl_ctx->crl_last_size == crl_stat.st_size)
>          && (ssl_ctx->crl_last_mtime.tv_sec == crl_stat.st_mtime))
> ...
>      ssl_ctx->crl_last_mtime.tv_sec = crl_stat.st_mtime;
>      ssl_ctx->crl_last_size = crl_stat.st_size;
>
>
> Antonio, this is your code - how shall we handle this?
>
> Today, we only use seconds, so "struct timeval" on all platforms would
> be good enough.  Some platforms' "struct stat" actually has a st_mtim
> which is a "struct timespec" (and st_mtime is defined as st_mtim.tv_sec),
> so if we ever go for subsecond accuracy, timespec is the right thing to
> do - OTOH, that will need at least one extra configure test, given
> how various OSes <sys/stat.h> weasle around "struct timespec"...
>
> #if (_POSIX_C_SOURCE - 0) >= 200809L || (_XOPEN_SOURCE - 0) >= 700 || \
>      defined(_NETBSD_SOURCE)
>          struct    timespec st_atim;     /* time of last access */
>          struct    timespec st_mtim;     /* time of last data modification */
>          struct    timespec st_ctim;     /* time of last file status change */
>          struct    timespec st_birthtim; /* time of creation */
> #else
>          time_t    st_atime;             /* time of last access */
>          long      st_atimensec;         /* nsec of last access */
>          time_t    st_mtime;             /* time of last data modification */
>          long      st_mtimensec;         /* nsec of last data modification */
> ...
>
>
> So, it might be worth considering just dropping the notion of interest
> in subseconds, and go for a plain "time_t" for "crl_last_mtime"...
> (slightly more code changes, but less portability hassle).
>
> Again, Antonio, your call...
>
>
> Eric, could you re-send the patch without the crypto_openssl.c and
> ssl_openssl.h hunks?  I could merge the rest while Steffan and Antonio
> ponder these changes...
>
> gert



