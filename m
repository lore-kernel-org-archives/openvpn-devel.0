Date: Tue, 4 Jul 2023 17:39:18 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZKQ9Jt3Q11A9t5YK@...2685...>
References: <20230704140805.3851328-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20230704140805.3851328-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Mock openvpn_exece on win32 also for
 test_tls_crypt
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Jul 04, 2023 at 04:08:05PM +0200, Arne Schwabe wrote:
> This function is needed to commpile on win32 as run_command.c defines it
> on Unix Linux but on windows it is defined in win32.c which pulls in too
> many other unresolvable symbols.

Also need to add mock_win32_execve.c in Makefile.am.

Regards,
-- 
  Frank Lichtenheld

