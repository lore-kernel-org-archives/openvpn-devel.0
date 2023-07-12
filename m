Date: Wed, 12 Jul 2023 13:17:28 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZK6LyL4M6YvDzgIw@...2685...>
References: <20230704140805.3851328-1-arne@...1227...>
 <20230712095412.570106-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20230712095412.570106-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Mock openvpn_exece on win32 also for
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

On Wed, Jul 12, 2023 at 11:54:12AM +0200, Arne Schwabe wrote:
> This function is needed to commpile on win32 as run_command.c defines it
> on Unix Linux but on windows it is defined in win32.c which pulls in too
> many other unresolvable symbols.
> 
> Patch v2: Also add mock_win32_execve.c to automake files

I checked "make distdir" and the file now appears in there.

Please note that this should be merged BEFORE
"Check if the -wrap argument is actually supported by the platform's ld"
since it fixes the MinGW build issue that arises from that.

Acked-by: Frank Lichtenheld <frank@...2641...>

-- 
  Frank Lichtenheld

