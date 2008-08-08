Date: Fri, 8 Aug 2008 16:38:40 +0200
From: Jos Vos <jos@...1120...>
Message-ID: <20080808143840.GB32056@...1119...>
References: <200808081133.m78BXp4S030182@...1119...>
	<35f70db10808080726s42b672eja344ef7557bf0e24@...278...>
Mime-Version: 1.0
In-Reply-To: <35f70db10808080726s42b672eja344ef7557bf0e24@...278...>
Subject: Re: [Openvpn-devel] OpenVPN and OpenSSL compatibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Ross Cameron <ross.cameron@...1049...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, Aug 08, 2008 at 04:26:47PM +0200, Ross Cameron wrote:

> What Linux kernel and Glibc version's are you running on this box?

Kernel 2.4.20, glibc 2.2.5.

But I just finished building a newer version of OpenSSL (0.9.7a,
still old, I know), then I compiled OpenVPN 2.1_rc9 against that,
and that does not give the errors anymore.

So it really seems that OpenSSL 0.9.6b is just one bridge too far...

-- 
--    Jos Vos <jos@...1120...>
--    X/OS Experts in Open Systems BV   |   Phone: +31 20 6938364
--    Amsterdam, The Netherlands        |     Fax: +31 20 6948204

