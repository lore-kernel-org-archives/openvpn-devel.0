Date: Tue, 23 Mar 2021 13:59:52 +0100 (CET)
Message-Id: <202103231259.12NCxqPj049609@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210317160038.25828-2-arne@...1227...>
References: <20210317160038.25828-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move NCP saving and restore to
 the prepush restore code
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

Your patch has been applied to the master branch.

As discussed with Antonion on IRC, we have no real testbed to test this
code change ("connect to server A that pushes options, disconnect, then
connect to server B that *does not* push anything").  I did some manual
tests with

 - a client config that has multiple <connection> entries, to servers
   that push different cipher settings or have OCC or nothing.
 - using the client management interface and SIGHUP/SIGUSR1, remote SKIP,
   remote ACCEPT to "walk to the next server"

    - talk to a NCP enabled server, which pushes "cipher AES-256-GCM"
    - then talk to a 2.3 server with --enable-small, which does not
      understand NCP or OCC -> client falls back to o->ciphername
      (by means of data-cipher-fallback), using "cipher BF-CBC",
      *if properly restored*

 - using SIGUSR1, things actually break (server A pushes "compress lz4",
   server B does not do that, but the client still is in "LZ4 mode",
   logs "Bad LZ4 decompression header byte: 250").  But this is an older
   issue (my test candidate is f6dca235ae560597, which is before this
   patch set) - and Arne already found that this is is because we neglect
   to *save* compression settings in options_pre_pull...

 - using SIGHUP, things work

In addition to this, the patch survived a very close stare-at-code and 
extensive t_client runs :-)

commit 7064ccb9fd3578c0b25713b1c8e620ad9449f7f4
Author: Arne Schwabe
Date:   Wed Mar 17 17:00:37 2021 +0100

     Move NCP saving and restore to the prepush restore code

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210317160038.25828-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21674.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


