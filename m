References: <1535550583-21825-1-git-send-email-steffan.karger@...1435...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <6f98b145-53cc-f4f9-af77-3804c477d075@...1227...>
Date: Thu, 30 Aug 2018 12:56:39 +0200
MIME-Version: 1.0
In-Reply-To: <1535550583-21825-1-git-send-email-steffan.karger@...1435...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH] Fix memory leak after sighup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

Am 29.08.18 um 15:49 schrieb Steffan Karger:
> The c.es env_set is (re)allocated for each "sighup loop iteration", while
> it was free'd only once at process shutdown.  Move the env_set_destroy()
> call to match the same level as the env_set_create() call to fix that.
> 

Acked-by: Arne Schwabe <arne@...1227...>

This like the right fix and even though the leak is small we should fix
it nevertheless.

Arne

