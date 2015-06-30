Message-ID: <55922E18.2060204@...1227...>
Date: Tue, 30 Jun 2015 07:50:16 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1435611582-26553-1-git-send-email-steffan@...1856...>
In-Reply-To: <1435611582-26553-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Increase control channel packet size
 for faster handshakes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 29.06.15 um 22:59 schrieb Steffan Karger:
> Instead of limiting the control channel TCP/UDP packet payload size at
> '100 bytes + real control channel overhead' (~140 bytes ethernet payload),
> increase the max TCP/UDP payload size to '1250 bytes - calculated overhea=
d'
> (~1210 bytes ethernet payload).  This decreases the number of packets
> required to establish a connection by a factor 10, but still has a
> comfortable enough margin to succeed for lower-MTU connections.
>
> This should especially help out for complex configs (trac #545), but also
> for high-latency connections (trac #543).
>
> Note that this patch does *not* yield an optimal solution, but it is a
> simple and rather safe change that will improve connection setup times
> significantly.
>
I have no experience with the code and what happens on a small MTU
connection. Are there still very strange small MTU connections (like 56k
dialup modems) around? On the other hand the OpenVPN 3.0 also uses
1200ish packet.

Arne


