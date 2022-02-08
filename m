Date: Tue, 8 Feb 2022 21:59:22 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1019065492.66755.1644353962956@...2642...>
In-Reply-To: <20220208114905.100-1-lstipakov@...277...>
References: <20220208114905.100-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] msvc: cleanup
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



> Lev Stipakov <lstipakov@...277...> hat am 08.02.2022 12:49 geschrieben:
> 
>  
> From: Lev Stipakov <lev@...515...>
> 
> Remove unused macros for dependency directories,
> since dependencies are handled by vcpkg.
> 
> Remove unused .bat files.
> 
> Reported-by: Frank Lichtenheld <frank@...2641...>

Thanks for the quick reaction to my ramblings :)

Acked-By: Frank Lichtenheld <frank@...2641...>
But only compile-tested, so not sure whether that should suffice.

One thing I noticed while building:

FOR /F %i IN ('where rst2html.py') DO python %i "c:\OpenVPN\openvpn\/doc/openvpn.8.rst" "c:\OpenVPN\openvpn\/doc/openvpn.8.html"

This is clearly outdated code from before the rst split. But probably not something that needs to be addressed in this patch.

Regards,
--
Frank Lichtenheld

