Message-ID: <4D5CF955.3030507@...68...>
Date: Thu, 17 Feb 2011 11:32:53 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1297893314-9037-1-git-send-email-g.esp@...260...>
In-Reply-To: <1297893314-9037-1-git-send-email-g.esp@...260...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] Fix warning: format not a string
 literal and no format arguments
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Am 16.02.2011 22:55, schrieb Gilles Espinasse:
> Seen with gcc-4.4.5 and -Wformat -Wformat-security
> 
> Signed-off-by: Gilles Espinasse <g.esp@...260...>
> ---
>  options.c |    6 +++---
>  push.c    |    4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)

Good catch, patch approved.

-- 
Matthias Andree

