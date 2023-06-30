Date: Fri, 30 Jun 2023 11:40:02 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZJ6i8gLkufUB4OWN@...2685...>
References: <20230629215611.3292788-1-arne@...1227...>
 <20230629215611.3292788-3-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20230629215611.3292788-3-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] [CMake] Only add
 -Wno-stringop-truncation on supported compilers
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

On Thu, Jun 29, 2023 at 11:56:08PM +0200, Arne Schwabe wrote:
> The -Wno-stringop-truncation flag is only supported by some GCC versions
> and not by Clang (macOS, FreeBSD) at all.
> 
> Move the includes to the top the file to have them available when running
> the check_c_compiler_flag.


Acked-by: Frank Lichtenheld <frank@...2641...> 

-- 
  Frank Lichtenheld

