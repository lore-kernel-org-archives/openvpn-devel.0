References: <20210402134529.27866-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <cfee9db2-1049-ea4f-7c6f-24ecaba6e4c7@...1227...>
Date: Fri, 2 Apr 2021 16:23:00 +0200
MIME-Version: 1.0
In-Reply-To: <20210402134529.27866-1-gert@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Fix 'compress migrate' for 2.2 clients.
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 02.04.21 um 15:45 schrieb Gert Doering:
> Commit 8fa8a17528c001a introduces "compress migrate" to move old clients
> that have "compress" or "comp-lzo" in their config towards a connection
> without compression.  This is done by looking at incoming OCC strings
> to see if the client has compression enabled, and at incoming IV_
> strings to see whether it can do "compress stub-v2" or needs to be sent
> "comp-lzo no".
> 
> That check fails for 2.2 clients that do not send *any* peer-info by
> default, so the server will not push back any "disable compression"
> command.  It works if the client connects with "--push-peer-info".
> 
> Fix: turn around the order of checks, treat "no peer_info" the same
> as "peer_info does not contain IV_COMP_STUBv2".

I actually did not test with 2.2 so I didn't notice this but the patch
looks good.

Acked-By: Arne Schwabe <arne@...1227...>

