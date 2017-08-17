References: <20170815215451.21662-1-davids@...515...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ede38864-9bf4-7cdf-252f-7fcdf9b04d2d@...1227...>
Date: Thu, 17 Aug 2017 17:13:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170815215451.21662-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Highlight deprecated features
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Sommerseth <davids@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 15.08.17 um 23:54 schrieb David Sommerseth:
> We have quite a list of deprecated options currently.  Ensure this
> is highlighted both in documentation and code.
> 
> This patch builds on the wiki page [1] enlisting all deprecated features
> and their status.  There are also some options not listed here, as
> there exists patches in release/2.4 which awaits an update for git master.
> 


I think tls-remote-name (or what was it called?) which has been replaced
by verify-x509-name should be in the list. It has already been removed
from master and is deprecated since 2.3?

Arne

