Message-ID: <5436E6E5.8060002@...1856...>
Date: Thu, 09 Oct 2014 21:49:57 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <CAGyAFMXhPTamN5tZYr92=re8Bhxky=priWS8UhCU3E_p2D8-mQ@...278...>	<CAGyAFMV6kZzTFwdp21n8GTNa-fbPx_S-TpYjpiC+R862WoMhAA@...278...>	<53B03B43.2040009@...1227...>
	<53BD10EB.9010509@...1227...>	<alpine.DEB.2.02.1408121108120.3669@...1831...>
	<CAGyAFMVzDaygh1d-jtZSRXYqq+hm5qphmtEQE8f7eyhpD8Am_w@...278...>
In-Reply-To: <CAGyAFMVzDaygh1d-jtZSRXYqq+hm5qphmtEQE8f7eyhpD8Am_w@...278...>
Subject: Re: [Openvpn-devel] session-id implementation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi Lev,

On 02-10-14 13:47, Lev Stipakov wrote:
> Apologize for the delay. Patch with review suggestions attached.

Thanks for providing the patch, and following up on comments on the
list. I've been deferring a reply to your first version, because I
wanted to take a thorough look at the code before replying, but somehow
did not get to it. Sorry. So, instead of deferring further, I'll just
mail what's in my head at this point.

I think your approach is a good alternative to the original proposal. I
like that it requires less bytes in the message. However, I think we
should arrange maybe a community meeting to discuss your alternative and
choose our way forward.

For now, some things I noticed while taking a quick peek at your patch.
Since I mostly focus on the crypto bits of openvpn, my remarks focus on
the crypto part of your patch too. I haven't looked at the other parts.

1) Your patch introduced a memcmp() call to verify an HMAC. That would
introduce a timing side channel we just got rid of in commit 11d2134.
Please *always* use use constant time comparisons when checking HMACs.
OpenVPN provides a memcmp_constant_time().

2) The crypto_test_hmac() function your patch introduces duplicates a
lot of code from openvpn_decrypt(). I don't like to maintain more code
than absolutely necessary ;) So, please add some functions to reuse the
code. Also, I think the hard-coded offset in that function is a bit ugly.

3) The three-byte offset helps to align the data on 32-bit blocks, but I
am trying to remember what the specific reason for this was. If it was
to speed up the crypto, we should make sure its 128-bits aligned,
because SSE/AES-NI instructions require 128-bits aligned data. (Though
that would probably only be useful for CBC mode, since in CFB/OFB/GCM,
the AES-operations are not actually performed the packet data buffer.)

-Steffan

