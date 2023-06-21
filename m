Date: Wed, 21 Jun 2023 15:00:58 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZJL0iuACtP5ruMdF@...2685...>
References: <20230619132934.76085-3-frank@...2641...>
 <202306211218.35LCIR0M060682@...2054...>
MIME-Version: 1.0
In-Reply-To: <202306211218.35LCIR0M060682@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: vcpkg-ports/pkcs11-helper:
 rename patches to make file names shorter
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

On Wed, Jun 21, 2023 at 02:18:27PM +0200, Gert Doering wrote:
> Acked-by: Gert Doering <gert@...1296...>
> 
> Indeed, this fixes bundling for the one patch with an extra-long name
> (so the tar file diffs have 2 file renames, plus one extra file).
> 
> To verify whether things still build, I've run via local mingw build
> (works) and GHA (works).
> 
> This does not apply to release/2.6, because the "fix build with disable 
> shared" commit (commit 17746e53f6) is not in 2.6.  Do we need it there?

Not right now. But if we want to merge CMake to release/2.6 we will need
to merge the pkcs11 changes as well and then we need this patch as well.

The CMake patches will also not apply cleanly on release/2.6 so we would
need to make a separate patch series for that anyway.

> Your patch has been applied to the master branch.
> 
> commit 0c25a5462e945f537d1836b47a5f147a2132875c
> Author: Frank Lichtenheld
> Date:   Mon Jun 19 15:29:32 2023 +0200
> 
>      vcpkg-ports/pkcs11-helper: rename patches to make file names shorter
> 
>      Signed-off-by: Frank Lichtenheld <frank@...2641...>
>      Acked-by: Gert Doering <gert@...1296...>
>      Message-Id: <20230619132934.76085-3-frank@...2641...>
>      URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26747.html
>      Signed-off-by: Gert Doering <gert@...1296...>
> 
> 
> --
> kind regards,
> 
> Gert Doering
> 

-- 
  Frank Lichtenheld

