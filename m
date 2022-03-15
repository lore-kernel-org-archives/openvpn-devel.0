Date: Tue, 15 Mar 2022 12:21:18 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <761409381.336352.1647343278208@...2642...>
In-Reply-To: <20220218235004.269-1-lstipakov@...277...>
References: <20220218235004.269-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] msvc: adjust build options to harden
 binaries
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

Acked-By: Frank Lichtenheld <frank@...2641...>

Build-tested on Win 10 with VS 2019.

> Lev Stipakov <lstipakov@...277...> hat am 19.02.2022 00:50 geschrieben:
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

Regards,
--
Frank Lichtenheld

