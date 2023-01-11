Date: Wed, 11 Jan 2023 08:32:48 +0100 (CET)
Message-Id: <202301110732.30B7Wm7r067496@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230111062910.1846688-1-selva.nair@...277...>
References: <20230111062910.1846688-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Include CE_DISABLED status of
 remote in remote-entry-get response
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

This is really straightforward.  Tested with my .ovpn full with generated
"remote" lines, some of them changed to "tcp", and "--proto-force tcp-client"

..
190,1185.server.org,1185,udp,disabled
191,1186.server.org,1186,udp,disabled
192,1187.server.org,1187,udp,disabled
193,1188.server.org,1188,tcp-client,enabled
194,1189.server.org,1189,tcp-client,enabled
195,1190.server.org,1190,tcp-client,enabled

(NOTE: "--proto-force tcp" will surprisingly - to me - disable *everything*,
because "client side TCP profiles are 'tcp-client', not 'tcp'")


This said, the code with all these strlen() and malloc() calls for every
single remote looks fumbly...  given that it's not exactly geared for
maxmimum memory efficientcy, I'm tempted to suggest just having an
on-the-stack "char remote[1000];" in man_remote_entry_get(), and pass
a pointer to that + sizeof() to "...callback.remote_entry_count()".

But this is something for the next round of cleanup in early 2.7.


I have reordered the example lines in the commit message.

Your patch has been applied to the master and release/2.6 branch.

commit eafbedc583c48fd46405fa0d635c688ce59c3733 (master)
commit 69383817b9805137460c0e25ede4b18573cac01d (release/2.6)
Author: Selva Nair
Date:   Wed Jan 11 01:29:10 2023 -0500

     Include CE_DISABLED status of remote in remote-entry-get response

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230111062910.1846688-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/search?l=mid&q=20230111062910.1846688-1-selva.nair@...277...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


