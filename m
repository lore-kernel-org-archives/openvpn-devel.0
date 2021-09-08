Date: Wed, 8 Sep 2021 11:51:13 +0200 (CEST)
Message-Id: <202109080951.1889pDbb005643@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210904095629.6273-4-a@...2181...>
References: <20210904095629.6273-4-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: reject compression by default
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

This needed a bit of massaging for the Changes.rst hunk.  The rest
was straightforward.

The interaction of this with existing configs is interesting.

 - if the local config has "comp-lzo" or "compress <something>" in it,
   this will still work(!) - because the "allow-compress no" changed 
   default will only become active after the config is parsed
   (and the client will announce IV_LZO=1 to the server)

 - if the local config has *no* "comp-lzo" or "compress" statements,
   "allow-compress no" becomes active, and no IV_LZO/IV_LZ4 is sent
   to the server

 - if the local config has no compression setting but --compat-mode 2.3.0
   is set, we also announce IV_LZO/IV_LZ4 to the server

So the compat bit and changed default works, it is only "not active yet"
when reading the local config.  OTOH, users are free to put stuff into
their local config, including "allow-compression yes", to override the
new defaults - so I think this is okay, if properly understood.

Making the (possibly) changed "allow-compression" setting active already
when reading the config is a more intrusive change, as one would need to
recalculate defaults right upon hitting the "compat-mode" statement
(and the "compat-mode" statement would need to be *before* the "compress"
statement otherwise disallowed) - we could do that, but I'm not sure it's
worth it.  Definitely worth discussing.


One interesting side effect of the current code is that none of the 
t_client buildslaves break - because they all have "comp-lzo" in the
configs (for historic reasons, sorry...) and thus everything keeps
working :-) - need to modify these cases a add variants.


Your patch has been applied to the master branch.

commit 79367a3fde433d0660cc7122aa21c3c76ee6b2da
Author: Antonio Quartulli
Date:   Sat Sep 4 11:56:25 2021 +0200

     reject compression by default

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20210904095629.6273-4-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22797.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


