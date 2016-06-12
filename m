MIME-Version: 1.0
In-Reply-To: <ec25d8af-ecfe-19eb-9d86-4525300cde2f@...277...>
References: <ec25d8af-ecfe-19eb-9d86-4525300cde2f@...277...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 12 Jun 2016 18:10:30 +0200
Message-ID: <CAA1Abx+q7EVw1tD3mbdn2g016pL2KXjoNQ9FodVzvDAr+zyw0w@...278...>
Subject: Re: [Openvpn-devel] OpenVPN-mbedTLS depends on mbedTLS debug module
 - safe to remove?
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
To: Magnus Kroken <mkroken@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Sun, Jun 12, 2016 at 5:14 PM, Magnus Kroken <mkroken@...277...> wrote:
> Is it safe to remove the call to debug_set_threshold? Is it only used
> for more verbose logging, or can this cause a TLS error to not be
> noticed (or lead to other security implications)?

Yes, the debug_set_threshold() call is only used for more verbose
error logging.  Very useful for debugging problems, but not critical
for OpenVPN's operation or security.

-Steffan

