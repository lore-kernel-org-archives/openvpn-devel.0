References: <1444494889-28925-1-git-send-email-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <561A1470.40900@...1227...>
Date: Sun, 11 Oct 2015 09:49:04 +0200
MIME-Version: 1.0
In-Reply-To: <1444494889-28925-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Remove support for snappy compression.
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

Am 10.10.15 um 18:34 schrieb Gert Doering:
> LZ4 is using less CPU at similar performance, and it is easier to
> build and support for binary installs (as it does not require C++
> and a C++ runtime).  Since it was never supported in any formally
> released OpenVPN version, just drop it again.
> 
> This leaves in the compression opcode for Snappy for documentation
> purposes.
> 
> trac #617

ACK from me. Snappy is probably not used outside from testscripts.

Arne


