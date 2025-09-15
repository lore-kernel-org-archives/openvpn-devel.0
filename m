Date: Mon, 15 Sep 2025 14:00:13 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <aMf/zU6t5M1xAWz+@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
References: <CAH+fs=9O0-SdY=A3ujsV+bmcG2m64jeJ-rbCKqzGNuWp-d5rFw@...278...>
MIME-Version: 1.0
In-Reply-To: <CAH+fs=9O0-SdY=A3ujsV+bmcG2m64jeJ-rbCKqzGNuWp-d5rFw@...278...>
Subject: Re: [Openvpn-devel] openvpn3-linux: GCC15 errors
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
To: Marc Leeman <marc.leeman@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Sep 15, 2025 at 01:33:30PM +0200, Marc Leeman wrote:
> FYI, i've received a couple bugs wrt GCC15. For gdbuspp, I'll demote
> the free-no-heap error atm, still need to look into the second error.
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1114118
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1114248

The second issue should be fixed by
https://github.com/OpenVPN/openvpn3/commit/166f110f453bfd421eabc0b0e36455fee845dd3e
which will go into the next openvpn3-linux release.

FWIW it is not actually caused by GCC15 but by kernel header changes.

Regards,
-- 
  Frank Lichtenheld

