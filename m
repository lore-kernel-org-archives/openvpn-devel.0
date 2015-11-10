References: <1447192719-31381-1-git-send-email-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56426E5C.3060900@...1227...>
Date: Tue, 10 Nov 2015 23:23:24 +0100
MIME-Version: 1.0
In-Reply-To: <1447192719-31381-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix possible heap overflow on read
 accessing getaddrinfo() result.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

On 10.11.2015 22:58, Gert Doering wrote:
> This is a specific 2.3 bug as the code in master (to be 2.4) has been
> completely rewritten to properly handle dual-stack and multiple responses
> from getaddrinfo() proper.
>
> Bug found by Daniel Hirche using "gcc -fsanitize=address".  No possible
> exploits are known.
ACK.

Arne

