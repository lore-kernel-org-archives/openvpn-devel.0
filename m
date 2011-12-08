Message-ID: <4EE0951E.80900@...1114...>
Date: Thu, 08 Dec 2011 11:44:46 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1323303229-31079-1-git-send-email-davids@...1347...>
	<CAOazyz1wxUHB27gj0y7L048af-ajfqvZno5KjtFUC9Ad4Uqn3w@...278...>
In-Reply-To: <CAOazyz1wxUHB27gj0y7L048af-ajfqvZno5KjtFUC9Ad4Uqn3w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add a wrapper for access() when
 compiling via Visual Studio
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: David Sommerseth <davids@...1347...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/12/11 08:44, Alon Bar-Lev wrote:
> On Thu, Dec 8, 2011 at 2:13 AM, David Sommerseth <davids@...1347...>
> wrote:
>> +/* The POSIX access() function is called via _access() on Windows, 
>> + * defined in io.h + */ +#define HAVE_ACCESS 1 +#define access
>> _access +#pragma warning(disable : 4996) /* Avoid Visual Studio to
>> complain about access(), which is redefined */
> 
> Where is it defined? Anyway, won't it better: --- #ifdef access #undef
> access #endif #define access _access ---

I tried that approach as well, and I still got this warning:
- -------------------------------------------------------------------------
options.c(2619) : warning C4996: '_access': The POSIX name for this item
is deprecated. Instead, use the ISO C++ conformant name: _access. See
online help for details.
        c:\Program Files (x86)\Microsoft Visual Studio
9.0\VC\INCLUDE\io.h(185): see declaration of '_access'
options.c(2625) : warning C4996: '_access': The POSIX name for this item
is deprecated. Instead, use the ISO C++ conformant name: _access. See
online help for details.
        c:\Program Files (x86)\Microsoft Visual Studio
9.0\VC\INCLUDE\io.h(185): see declaration of '_access'
options.c(2629) : warning C4996: '_access': The POSIX name for this item
is deprecated. Instead, use the ISO C++ conformant name: _access. See
online help for details.
        c:\Program Files (x86)\Microsoft Visual Studio
9.0\VC\INCLUDE\io.h(185): see declaration of '_access'
options.c(2630) : warning C4996: '_access': The POSIX name for this item
is deprecated. Instead, use the ISO C++ conformant name: _access. See
online help for details.
        c:\Program Files (x86)\Microsoft Visual Studio
9.0\VC\INCLUDE\io.h(185): see declaration of '_access'
- -------------------------------------------------------------------------

In io.h:185, this line can be found:
- -------------------------------------------------------------------------
_Check_return_ _CRTIMP int __cdecl _access(_In_z_ const char * _Filename,
_In_ int _AccessMode);
- -------------------------------------------------------------------------

And access() is declared like this in io.h:303
- -------------------------------------------------------------------------
_Check_return_ _CRT_NONSTDC_DEPRECATE(_access) _CRTIMP int __cdecl
access(_In_z_ const char * _Filename, _In_ int _AccessMode);
- -------------------------------------------------------------------------

The only way around this warning was to use the #pragma declaration to
disable the C4996 warning.  But I'm no Visual Studio expert, I might have
overlooked something.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7glRwACgkQDC186MBRfrrM3QCgpgkDi4JWMaa4mmWjDeopDQfG
iWMAoKsMJC5zp4O9UwAwNtDXIM7wHkcB
=+4J5
-----END PGP SIGNATURE-----

