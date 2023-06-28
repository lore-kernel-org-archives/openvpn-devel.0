Date: Wed, 28 Jun 2023 13:27:11 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZJwZD3DW40vu3gbQ@...2685...>
References: <20230620135310.94455-4-frank@...2641...>
 <202306272008.35RK8Y7i002717@...2054...>
MIME-Version: 1.0
In-Reply-To: <202306272008.35RK8Y7i002717@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Remove all traces of the
 previous MSVC build system
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

On Tue, Jun 27, 2023 at 10:08:34PM +0200, Gert Doering wrote:
> This patch touches a large number of files, but all the source code
> changes are trivial (remove the "config-msvc.h" include).
> 
> The larger change "get rid of the evil MSVC xml files" is very 
> welcome :-) - one of the changes confuses me, though - this recent
> "tapctl.exe.manifest" inclusion in EXTRA_DIST, and now removing all
> of it again.  Was that intentional?

That was a "rebase" bug. Somehow I managed to introduce a second EXTRA_DIST.
So make dist might be slightly broken in the CMake commit. But this commit
then fixes it, so the end-state is correct.

> Github says "it still builds fine", and Lev has tested the resulting
> binaries, good enough for me :-)
> 
> I'm a bit unsure how to proceed with 2.6 - people are (trying to) build
> this with MSVC, so pulling up that changeset will break their ways of
> doing things.  And it's quite large...  OTOH, *not* pulling it in
> means we're stuck with MSVC building for 2.6 "until it reaches end of
> life", including regular updates to these XML files.
> 
> Your patch has been applied to the master branch.
> 
> commit 7fbb9484116dc5d9d618d74f1ee253cf6fef4101
> Author: Frank Lichtenheld
> Date:   Tue Jun 20 15:53:08 2023 +0200
> 
>      Remove all traces of the previous MSVC build system
> 
>      Signed-off-by: Frank Lichtenheld <frank@...2641...>
>      Acked-by: Lev Stipakov <lstipakov@...277...>
>      Message-Id: <20230620135310.94455-4-frank@...2641...>
>      URL: https://www.mail-archive.com/search?l=mid&q=20230620135310.94455-4-frank@...2641...
>      Signed-off-by: Gert Doering <gert@...1296...>

Regards,
-- 
  Frank Lichtenheld

