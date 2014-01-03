Message-ID: <52C6C264.3090802@...1435...>
Date: Fri, 3 Jan 2014 15:00:04 +0100
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
References: <20131230205032.GH226@...1296...>
	<1388607026-12297-1-git-send-email-steffan@...1856...>
	<1388607026-12297-7-git-send-email-steffan@...1856...>
	<52C6B86D.6070503@...1227...>
In-Reply-To: <52C6B86D.6070503@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 6/6] Disable export ciphers by default
 for OpenSSL builds.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 01/03/2014 02:17 PM, Arne Schwabe wrote:
> ACK. But isn't is better to use good to do the !EXP just in case and for
> consistency for PolarSSL as well.

I agree that would be nice for consistency, but since PolarSSL supports
neither export ciphers nor the 'DEFAULT'/'EXP'/etc cipher-suite group
names that's not possible.

-Steffan

