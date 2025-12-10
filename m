Date: Wed, 10 Dec 2025 12:02:32 +0100 (CET)
Message-Id: <202512101102.5BAB2WHA011371@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251210104839.8270-1-gert@...1296...>
References: <20251210104839.8270-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: mudp: fix unaligned 32-bit read
 when parsing peer ID
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Not sure the new code is less or more ugly than the old code... but it's
less ugly than v1 of the patch :-)

I have lightly tested this, and instrumented my t_server test bed to
add an ASSERT(old_peer_id == peer_id) check.  I do not have peer IDs > 255,
and the p2p mode (which uses random-high peer IDs) does not use *this*
code path, so "exposure to higher peer-id" has not been tested.

That said, the byte order handling is correct for peer-ids 1 and 2, and
stare-at-code suggests it should work fine for up to 24 bits too :-)

*That* said, I'm not sure if this is really a relevant "finding" - yes,
it could end up doing unaligned 32bit-reads, but on Intel, this is "just
slow" - which byte accesses are, too.  The only platform I'm aware that
will trap-and-die is SPARC32, and even that should be fine with the code
that has been in there for a loooong time...  but anyway.  I don't think
this makes a huge difference either way.

Your patch has been applied to the master branch.

commit 8bf8bead6d7cc3c743fdf2b915fbb2f3f24e7005
Author: Gianmarco De Gregori
Date:   Wed Dec 10 11:48:33 2025 +0100

     mudp: fix unaligned 32-bit read when parsing peer ID

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1348
     Message-Id: <20251210104839.8270-1-gert@...1296...>
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


