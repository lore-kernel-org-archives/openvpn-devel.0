References: <CAA1AbxJbSppAHLtDiD3mVRee9Qk=p0dWeDyfix-f4YjVW-snjw@...278...>
	<1462438933-14902-1-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <572B2233.8060403@...1227...>
Date: Thu, 5 May 2016 12:36:35 +0200
MIME-Version: 1.0
In-Reply-To: <1462438933-14902-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v2] mbedtls: check that private key and
 certificate match on start
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 05.05.16 um 11:02 schrieb Steffan Karger:
> Implement a long standing todo in the code, now that we use mbed TLS 2.x,
> which provides an interface for the check.
> 
> v2: bail out immediately on failure.
> 

ACK from me.

Arne


