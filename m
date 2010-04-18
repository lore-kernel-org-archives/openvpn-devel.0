Date: Sun, 18 Apr 2010 16:07:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100418140713.GZ12312@...1296...>
References: <1271449313-26315-1-git-send-email-openvpn.list@...1114...>
Mime-Version: 1.0
In-Reply-To: <1271449313-26315-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCHv2 0/3] Harden create_temp_filename()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: David Sommerseth <openvpn.list@...1114...>
Cc: James Yonan <james@...515...>, David Sommerseth <dazo@...384...>, Openvpn-devel@lists.sourceforge.net

Hi,

On Fri, Apr 16, 2010 at 10:21:50PM +0200, David Sommerseth wrote:
> In a Debian bug report [1] there were worries that the --client-connect
> script hook was prune to a "symlink" attack.  Even though this can
> be recognised if --tmp-dir is set to a world writable directory, it is not
> considered standard practice to do so.
> 
> This patch-set replaces the previous suggested patch, with an enhancement
> suggested by Fabian Knittel.  In addition create_temp_filename() is renamed
> to create_temp_file() to reflect the behvioural change in the function.

Overall, this looks good to me (with the additional changes by Fabian
and you).  So ACK.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

