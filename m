From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] New pre-1.3.3 beta
Message-ID: <20030315162254.GA6206@...33...>
References: <200303150747.h2F7lE427908@...41...>
Mime-Version: 1.0
In-Reply-To: <200303150747.h2F7lE427908@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Mar 15 08:24:03 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Sat, 15 Mar 2003, James Yonan wrote:

> If you have a chance, please test this beta.  I mostly use linux 2.4 for
> development, so I don't have much of a chance to test on linux 2.2 and
> non-linux OSes.

There are some warnings with Sun's compiler about uint8_t vs. char
clashes. Do you intend to silence the warnings or are you interested to
see them? I think they're harmless but annoying.

Other than that, it compiles on FreeBSD 4.8-RC x86 and Solaris 8 sparc
(32-bit mode), on the latter with Sun's compiler and gcc 2.95.

-- 
Matthias Andree

