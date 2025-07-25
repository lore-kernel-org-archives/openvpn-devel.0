Date: Fri, 25 Jul 2025 17:37:46 +0200 (CEST)
Message-Id: <202507251537.56PFbkvY016109@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250725124415.20645-1-gert@...1296...>
References: <20250725124415.20645-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: plugins: Clean up -Wconversion
 warnings
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Stared long and hard at the changes, some of which clearly look like
I and others have been busy copy-pasting sample code around :-)

I haven't actually tested this beyond a test-compile ("make all" in
the sample-plugins directory, the BBs test-compiling the other
plugins) - easy and straightforward enough.  I took note there is
an "useconds_t" now, but I guess that all platforms having usleep()
will also have this...

Your patch has been applied to the master branch.

commit df3ac551259865a0826d4571a3ae48bb1bdf38e3
Author: Frank Lichtenheld
Date:   Fri Jul 25 14:44:09 2025 +0200

     plugins: Clean up -Wconversion warnings

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250725124415.20645-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32330.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


