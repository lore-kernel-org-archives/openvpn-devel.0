From: Steffan Karger <steffan@...1856...>
Message-ID: <569285BE.40605@...1856...>
Date: Sun, 10 Jan 2016 17:24:30 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] Please comment: AEAD support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

For a while now I've been spending some time on adding AEAD support to 
OpenVPN.  I published a branch containing my most recent patch set on 
github:
https://github.com/syzzer/openvpn/tree/aead-cipher-modes11

The meat of it is in this commit, of which the commit message provides 
useful information:
https://github.com/syzzer/openvpn/commit/b0dc773a

I expect to send a patch set to the list soon, but preliminary comments 
and test results are very much welcome.

Once this is done, I will continue working on cipher negotiation.

(The commits with a title starting with XXX are just for easier 
testing/debugging and will not be part of the final patch set).

-Steffan

