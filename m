Message-ID: <f695d3ae-d137-4d9b-d4e2-7d708f41ac94@...1227...>
Date: Fri, 13 May 2022 13:17:32 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220513101526.11486-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220513101526.11486-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Pass proper sockaddr_* structure for
 IPv6 socket errors.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 13.05.22 um 12:15 schrieb Gert Doering:
> commit 043c67f363429 enhances format_extended_socket_error() by
> recognizing IPv6 extended socket errors, but neglected to change
> the "sockaddr_in" buffer passed to recvmsg() to "sockaddr_storage".
> 
> According to documentation, recvmsg() should not have overrun
> that structure (we pass the size of the struct), but according to
> ASAN it does... so, pass the correct structure.
> 

Acked-By: Arne Schwabe <arne@...1227...>

