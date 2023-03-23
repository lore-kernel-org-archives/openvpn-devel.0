Date: Thu, 23 Mar 2023 20:12:33 +0100 (CET)
Message-Id: <202303231912.32NJCXQE052156@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230323170601.1256132-2-arne@...1227...>
References: <20230323170601.1256132-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Refuse connection if server
 pushes an option contradicting allow-compress
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

Acked-by: Gert Doering <gert@...1296...>

We had a long and heated discussion about this... I wanted a 3-liner that
just does the "if (DCO && compression) { explode(); }" bit, but this is
indeed making the code more readable - and my fix might have interfered
with server / ccd/ option handling anyway.

This patch in itself does not change any behaviour yet (= a client
without any compression option in its config will accept "comp-lzo no",
going to stub mode, and will not accept "compress $nonstub").

Tested over dinner on the client/server testbeds, with and without
compression.  This all passed.

I have also tested pushing a compression option to an "unsuspecting 
client" ("comp-lzo no" works, "compress lz4" is refused) and also having
something in ccd/ on an "unsuspecting DCO server without compression"
(will reject the client, even for "comp-lzo no" or "stub-v2").

"compress migrate" plus a client with "comp-lzo" will also still do
the right thing and push "compress stub-v2".

Your patch has been applied to the master and release/2.6 branch.

commit e86bc8b2967484afdb1e96efddb8d91185c4cc2c (master)
commit e950ca1b9fca58e97aacedc5c0229856aa1e4e86 (release/2.6)
Author: Arne Schwabe
Date:   Thu Mar 23 18:05:59 2023 +0100

     Refuse connection if server pushes an option contradicting allow-compress

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230323170601.1256132-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26503.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


