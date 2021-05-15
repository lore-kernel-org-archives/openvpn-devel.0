Date: Sat, 15 May 2021 18:28:11 +0200 (CEST)
Message-Id: <202105151628.14FGSBtt014874@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210510131356.968965-1-arne@...1227...>
References: <20210510131356.968965-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use exponential backoff for
 caching in tls_authentication_status
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

As discussed on IRC, this patch fixes most of the shortcomings in
the previous patch (9a430502077).

I still find these code paths very complicated, but after running 
the server test side with added logging to see when the cache kicks
in and what sort of delay is induced, I think I can say "this makes
sense" - and it does not break any of the existing test scenarios, 
which is good :-)

While still complicated, it actually simplifies the overall flow, as
there is no extra "latency" parameter anymore, which does magic things,
depending on where it's called from.

Also, I was slightly confused on the actual effect of the cache/delay - 
this is really only relevant for the initial authentication (and not for
TLS renegotiation) and only while the auth control file status is not yet 
known.  So for all other code paths, and for "inotify" paths (triggered
check of the ACFs) this just makes the code more simple -> more good.

Your patch has been applied to the master branch.

commit d49df6bdde0592c9f795a2a260f6f04255b32303
Author: Arne Schwabe
Date:   Mon May 10 15:13:56 2021 +0200

     Use exponential backoff for caching in tls_authentication_status

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210510131356.968965-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22327.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


