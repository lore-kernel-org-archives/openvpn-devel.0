References: <20210328122255.29764-1-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <7f92c4f2-074b-0b3f-de16-1cc8ef870e19@...1856...>
Date: Sun, 28 Mar 2021 14:48:52 +0200
MIME-Version: 1.0
In-Reply-To: <20210328122255.29764-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Remove flexible array member autoconf
 check
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 28-03-2021 14:22, Arne Schwabe wrote:
> This is configure macro that tries out how to declare a variable array
> at the end of struct. This has been standardised in C99, so there is
> no more need for non C99 magic. See also this stackoverflow discussion:
> 
> https://stackoverflow.com/questions/14643406/whats-the-need-of-array-with-zero-elements
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  config-msvc.h           |  1 -
>  m4/ax_emptyarray.m4     | 40 ----------------------------------------
>  src/openvpn/circ_list.h |  2 +-
>  src/openvpn/syshead.h   |  2 --
>  4 files changed, 1 insertion(+), 44 deletions(-)
>  delete mode 100644 m4/ax_emptyarray.m4
> 
> diff --git a/config-msvc.h b/config-msvc.h
> index e430ca96f..0260927ce 100644
> --- a/config-msvc.h
> +++ b/config-msvc.h
> @@ -119,7 +119,6 @@
>  #define inline __inline
>  #endif
>  
> -#define EMPTY_ARRAY_SIZE 0
>  #define TARGET_WIN32 1
>  #define TARGET_ALIAS "Windows-MSVC"
>  
> diff --git a/m4/ax_emptyarray.m4 b/m4/ax_emptyarray.m4
> deleted file mode 100644
> index c6781c179..000000000
> --- a/m4/ax_emptyarray.m4
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -dnl @synopsis AX_EMPTY_ARRAY
> -dnl
> -dnl Define EMPTY_ARRAY_SIZE to be either "0"
> -dnl or "" depending on which syntax the compiler
> -dnl prefers for empty arrays in structs.
> -dnl
> -dnl @version
> -dnl @author James Yonan <jim@...41...>
> -AC_DEFUN([AX_EMPTY_ARRAY], [
> -	AS_VAR_PUSHDEF([VAR],[ax_cv_c_empty_array])dnl
> -	AC_CACHE_CHECK(
> -		[for C compiler empty array size],
> -		[VAR],
> -		[AC_COMPILE_IFELSE(
> -			[AC_LANG_PROGRAM(
> -				,
> -				[[
> -struct { int foo; int bar[0]; } mystruct;
> -				]]
> -			)],
> -			[VAR=0],
> -			[AC_COMPILE_IFELSE(
> -				[AC_LANG_PROGRAM(
> -					,
> -					[[
> -struct { int foo; int bar[]; } mystruct;
> -					]]
> -				)],
> -				[VAR=],
> -				[AC_MSG_ERROR([C compiler is unable to creaty empty arrays])]
> -			)]
> -		)]
> -	)dnl
> -	AC_DEFINE_UNQUOTED(
> -		[EMPTY_ARRAY_SIZE],
> -		[$VAR],
> -		[Dimension to use for empty array declaration]
> -	)dnl
> -	AS_VAR_POPDEF([VAR])dnl
> -])
> diff --git a/src/openvpn/circ_list.h b/src/openvpn/circ_list.h
> index 23b42d2ab..ba9115eab 100644
> --- a/src/openvpn/circ_list.h
> +++ b/src/openvpn/circ_list.h
> @@ -34,7 +34,7 @@
>          int x_size; \
>          int x_cap; \
>          int x_sizeof; \
> -        type x_list[EMPTY_ARRAY_SIZE]; \
> +        type x_list[]; \
>      }
>  
>  #define CIRC_LIST_PUSH(obj, item) \
> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
> index 5ee9bf1e8..cf9714593 100644
> --- a/src/openvpn/syshead.h
> +++ b/src/openvpn/syshead.h
> @@ -392,8 +392,6 @@ typedef int MIB_TCP_STATE;
>  #ifdef PEDANTIC
>  #undef HAVE_CPP_VARARG_MACRO_GCC
>  #undef HAVE_CPP_VARARG_MACRO_ISO
> -#undef EMPTY_ARRAY_SIZE
> -#define EMPTY_ARRAY_SIZE 1
>  #undef inline
>  #define inline
>  #endif
> 

Makes sense, and change looks good. This is just unneeded configure
delay. Ran a quick configure-make-check to double-check there's not a
trivial typo I'm overlooking.

I haven't tested compiling with MSVC.

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

