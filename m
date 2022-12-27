Date: Tue, 27 Dec 2022 10:23:47 +0100 (CET)
Message-Id: <202212270923.2BR9NlPs092650@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210907223126.8440-2-selva.nair@...277...>
References: <20210907223126.8440-2-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Permit unlimited connection
 entries and remotes
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

The patch needed a bit of convincing to go in (context change in options.h,
and braces-in-the-wrong-line).  Fixed.

Tested with a config with 200 somewhat random remote lines - without the
patch

  Options error: Maximum number of 'remote' options (64) exceeded

and with the patch "it just works"...

    remote-entry-count
    206
    END
    remote-entry-get 200 999
    200,1195.server.org,1195,udp
    201,1196.server.org,1196,udp
    202,1197.server.org,1197,udp
    203,1198.server.org,1198,udp
    204,1199.server.org,1199,udp
    205,1200.server.org,1200,udp
    END

(I did not try 100s of <connection>)


That said, I'm not convinced we really need to print

  2022-12-27 10:16:56 WARNING: Using --management on a TCP port WITHOUT passwords is STRONGLY discouraged and considered insecure

for every single --remote...  but that's a different issue, not caused
by *this* patch.

Your patch has been applied to the master branch.

commit 4954beb618e8bf2dc756019d5a36040d791a8f38 (master)
commit ceba452ee44439b426b786325db2b4e1b1c8b663 (release/2.6)
Author: Selva Nair
Date:   Tue Sep 7 18:31:25 2021 -0400

     Permit unlimited connection entries and remotes

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20210907223126.8440-2-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22816.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


