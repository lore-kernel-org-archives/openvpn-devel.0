Date: Wed, 20 Sep 2023 14:21:04 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZQrjsH0/Z6z8mXDu@...2685...>
References: <gerrit.1694783050000.I171d55da2be868d961caa1d4491e6f1ed10ebe8a@...2715...>
 <20230920121519.177949-1-frank@...2641...>
MIME-Version: 1.0
In-Reply-To: <20230920121519.177949-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] CMake: fix broken daemonization and
 syslog functionality
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
To: openvpn-devel@lists.sourceforge.net

On Wed, Sep 20, 2023 at 02:15:19PM +0200, Frank Lichtenheld wrote:
> From: Lev Stipakov <lev@...515...>
> 
> While CMake is not the official way to build OpenVPN on Linux,
> it still make sense to support it. Turns out that
> 
>   HAVE_SETSID, HAVE_OPENLOG and HAVE_SYSLOG
> 
> were not set by CMake configure, and --daemon and syslog
> functionality was broken.
> 
> While on it, fix compiler error on unused return value of chdir().
> 
> Change-Id: I171d55da2be868d961caa1d4491e6f1ed10ebe8a
> Signed-off-by: Lev Stipakov <lev@...515...>
> Acked-by: Arne Schwabe <arne-openvpn@...1227...>
> Acked-by: Frank Lichtenheld <frank@...2641...>
> ---
> 
> This change was reviewed on Gerrit and approved by at least one
> developer. I request to merge it to master.
> 
> Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/341
> This mail reflects revision 1 of this Change.
> Acked-by according to Gerrit (reflected above):
> Arne Schwabe <arne-openvpn@...1227...>
> Frank Lichtenheld <frank@...2641...>

So I can automatically set In-Reply-To to the same "virtual" message
ID that Gerrit uses (since that is deterministally constructed from
the change metadata). However, since this is not the actual message ID
by the original "newchange" mail, it still doesn't associate to the
same "Patch" in Patchwork. Instead it creates a new patch.

Regards,
-- 
  Frank Lichtenheld

