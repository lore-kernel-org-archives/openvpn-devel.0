References: <20200513141147.17171-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <a27e10be-e36f-e6b8-0b09-e32c4d9b8a60@...2181...>
Date: Wed, 13 May 2020 17:06:50 +0200
MIME-Version: 1.0
In-Reply-To: <20200513141147.17171-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Change client side of t_lpback.sh
 configs to use inline material.
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

Hi,

On 13/05/2020 16:11, Gert Doering wrote:
> We have no real test rig for "inline" key material (key, cert, ca,
> tls-auth, tls-crypt*) yet.   This change adds the "sample" key set
> as inline config to the "loopback-client" config, while keeping
> file-based configs for "loopback-server" - that way, testing both
> methods of loading keys etc. in one go.
> 
> Signed-off-by: Gert Doering <gert@...1296...>

Very good idea - this way we should catch at least some basic inlining bugs.
We probably want to add (to the unit test) a run for checking genkey as
well.

In any case, I stared at the change and it looks good!

I did not run it myself but buildbot will immediately tell us if
something is wrong.


Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

