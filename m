Date: Tue, 19 Mar 2024 18:47:53 +0100 (CET)
Message-Id: <202403191747.42JHlreg043225@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240319151723.936-2-lev@...515...>
References: <20240319151723.936-2-lev@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: interactive.c: disable remote
 access to the service pipe
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

As for the "plugin loading", this patch was sent "with ACK included" to
the openvpn-devel@ list because it was developed under embargo (CVE),
and reviewed and ACKed in a closed group.  I have verified that this
patch is identical to the that Heiko and the original reporter saw and
ACKed.

It's not very clear if there is a real attack angle here, but generally
speaking this is a local process which only the GUI running on the
same machine should be speaking to, so we do not want arbitrary machines
in the network to be able to connect to its pipe and "try things".

I have test compiled this on MinGW and GHA, but did not actually run it.

Your patch has been applied to the master, release/2.6 and release/2.5
branch (security relevant bugfix).

commit 2c1de0f0803360c0a6408f754066bd3a6fb28237 (master)
commit a95e665041466ec7d4ca6dbf89d22c7950e9ef26 (release/2.6)
commit e0775c042c7908a9b315da8092b436d03abea08a (release/2.5)
Author: Lev Stipakov
Date:   Tue Mar 19 17:16:07 2024 +0200

     interactive.c: disable remote access to the service pipe

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Heiko Hund <heiko@...515...>
     Message-Id: <20240319151723.936-2-lev@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28419.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


