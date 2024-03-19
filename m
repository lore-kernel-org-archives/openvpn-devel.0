Date: Tue, 19 Mar 2024 19:08:40 +0100 (CET)
Message-Id: <202403191808.42JI8efB044166@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240319152803.1801-2-lev@...515...>
References: <20240319152803.1801-2-lev@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: interactive.c: Fix potential
 stack overflow issue
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

As for the two previous windows/CVE patches, this patch was sent "with
ACK included" to the openvpn-devel@ list because it was developed under
embargo (CVE), and reviewed and ACKed in a closed group.  I have verified
that this patch is identical to the "v2" version that Heiko and the original
reporter saw and ACKed. 

The patch looks larger than the actual code change, because to do the
size check the union typedef needs to move outside the function where
it was "local" before.  The actual check is very straightforward - "if
there is more data in the pipe than can fit into a pipe_message_t,
log an error and close this thread" (thus, abandon the process on the
other end that pretends to be openvpn.exe but is misbehaving).

In itself, this bug is annoying, but can not be directly exploited
(because you cannot "just talk to this pipe", but you need to be
openvpn.exe from the install directory).  Combined with other potential
flaws that give an attacker the opportunity to swap the openvpn.exe
binary or get a malicious plugin loaded, this could end up being a
local privilege escalation to SYSTEM.  No exploit is known so far - this
was found by code inspection for missing bounds checks.


I have test compiled this on MinGW and GHA, but did not actually run it.

Your patch has been applied to the master and release/2.6 branch
(security relevant bugfix).  A direct cherrypick to 2.5 fails due to
"sufficiently different code and data structures" so I've asked Lev
to send a 2.5 version which I could review-and-ACK then.

commit 989b22cb6e007fd1addcfaf7d12f4fec9fbc9639 (master)
commit 9b2693feff9c49b9485cf94797c1c3502259dbe1 (release/2.6)

Author: Lev Stipakov
Date:   Tue Mar 19 17:27:11 2024 +0200

     interactive.c: Fix potential stack overflow issue

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Heiko Hund <heiko@...515...>
     Message-Id: <20240319152803.1801-2-lev@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28420.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


