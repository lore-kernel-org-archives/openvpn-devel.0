Date: Tue, 15 Mar 2022 12:47:56 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1226140711.339401.1647344876665@...2642...>
In-Reply-To: <20220218235255.334-1-lstipakov@...277...>
References: <20220218235255.334-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2 release/2.5] msvc: adjust build
 options to harden binaries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

Acked-by: Frank Lichtenheld <frank@...2641...>

Build tested on Win10 VS 2019. See notes below about the patch
dependency.

> Lev Stipakov <lstipakov@...277...> hat am 19.02.2022 00:52 geschrieben:
> 
>  
> From: Lev Stipakov <lev@...515...>
> 
>  - enable hardware-enforced stack protection on
> compatible hardware/software (/CETCOMPAT linker option)
> 
>  - hash object files with SHA256 (/ZH:SHA_256 compiler option)
> 
>  - enable SDL. The required to add
> 
>     _CRT_NONSTDC_NO_DEPRECATE
>     _CRT_SECURE_NO_WARNINGS
>     _WINSOCK_DEPRECATED_NO_WARNINGS
> 
> preprocessor definitions. I don't feel like replacing strdup (which is
> correct POSIX function) and inet_ntoa (we always pass IPv4 address to
> it, inet_ntop will make code more complex)
> 
> Above issues were discovered by bitskim.
> 
> Before applying this patch, this one must be applied from master:
> 
> https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21774.html

Notes:
- This is e5e9a07e8baee4065b7dfd65736bfa77b8329cfc
- Automatic cherry-pick fails due to trivial conflict in copyright years
- Author of e5e9a07e8baee4065b7dfd65736bfa77b8329cfc is
  "Author: Simon Rozman via Openvpn-devel <openvpn-devel@lists.sourceforge.net>"
  so that is something that could be cleaned up on cherry-pick.

Regards,
--
Frank Lichtenheld

