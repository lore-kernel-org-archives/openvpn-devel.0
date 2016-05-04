MIME-Version: 1.0
In-Reply-To: <5729B2F2.2090201@...1400...>
References: <1462307959-26991-1-git-send-email-steffan@...1856...>
	<5729B2F2.2090201@...1400...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 4 May 2016 10:43:07 +0200
Message-ID: <CAA1AbxJbSppAHLtDiD3mVRee9Qk=p0dWeDyfix-f4YjVW-snjw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] mbedtls: check that private key and
 certificate match on start
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <schwabe@...1400...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Wed, May 4, 2016 at 10:29 AM, Arne Schwabe <schwabe@...1400...> wrote:
> Is there a reason to only warn? I have not tested this
> but OpenVPN fail later in combination or does the tls auth just "not work"?

It will fail later on (as it did before), but there is no good reason
to only warn here.  This should just fail right away.  I'll send a v2
(probably tonight or tomorrow).

-Steffan

