Date: Wed, 28 Jun 2023 13:31:23 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZJwaC49DpFNxRrxw@...2685...>
References: <20230620135310.94455-3-frank@...2641...>
 <202306271835.35RIZX0m000071@...2054...>
MIME-Version: 1.0
In-Reply-To: <202306271835.35RIZX0m000071@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: CMake: Add complete MinGW
 and MSVC build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Jun 27, 2023 at 08:35:33PM +0200, Gert Doering wrote:
> I have tested this by pushing to GHA (as there are quite significant
> changes to build.yaml) - it seems to still pass, which is good :-)
> 
> I do wonder why all unit tests now produce differently-named .exe
> files (packet_id_testdriver.exe -> test_packet_id.exe etc)?  Is this
> a side effect of a new cmocka version, or...?

No, there is no technical reason for this. I think we can freely choose
the name. We probably just applied the usual naming we use in all our
CMake code. While the autotools buildsystem uses a different naming
scheme.

The old MSVC build had no support for the UTs at all.

> This patch also adds bundling of the CMake related files to tarballs
> (which I missed in 1/5).  Good :-) - besides this, there should be no
> change to "autoconf based building", and there are also no code changes.
> 
> Your patch has been applied to the master branch.
> 
> commit e8881ec6dd63bd80ce05202573eac54ab8657fcb
> Author: Frank Lichtenheld
> Date:   Tue Jun 20 15:53:07 2023 +0200
> 
>      CMake: Add complete MinGW and MSVC build
> 
>      Signed-off-by: Frank Lichtenheld <frank@...2641...>
>      Acked-by: Lev Stipakov <lstipakov@...277...>
>      Message-Id: <20230620135310.94455-3-frank@...2641...>
>      URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26754.html
>      Signed-off-by: Gert Doering <gert@...1296...>

Regards,
-- 
  Frank Lichtenheld

