Message-ID: <50BE5DE2.5080008@...1227...>
Date: Tue, 04 Dec 2012 21:32:34 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1354482672-16136-1-git-send-email-gert@...1296...>
	<1354482672-16136-2-git-send-email-gert@...1296...>
In-Reply-To: <1354482672-16136-2-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Implement --mssfix handling for IPv6
 packets.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Am 02.12.12 22:11, schrieb Gert Doering:
> Rename process_ipv4_header() to process_ip_header() and PIPV4_MSSFIX
> flag to PIP_MSSFIX, to make visible that it's no longer IPv4-only.
>
> Inside process_ip_header(), call out to mss_fixup_ipv6() if --mssfix
> is active and IPv6 packet seen.
>
> Rename mss_fixup() to mss_fixup_ipv4(), implement mss_fixup_ipv6().
>
>
I have no setup with broken mss but I looked through the patch and I
think is the right fix.

Arne


