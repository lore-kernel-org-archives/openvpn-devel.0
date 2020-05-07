Date: Thu, 7 May 2020 21:53:57 +0200 (CEST)
Message-Id: <202005071953.047JrvYa049698@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200227205443.27562-1-davids@...515...>
References: <20200227205443.27562-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: build: Remove --disable-server
 from ./configure
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

Due to the recent uncrustify changes, mbedTLS bugfixes and lev's
key state / NCP changes, this needed a bit more force to go in - but
in the end, the changes are totally straightforward, and I've verified
that the code changes "after the fact" are really just #ifdef/#endif,
and that it still compiles :)

I have also reformatted the dangling "else<empty line>if" construct
in push.c as instructed.

Client tested on Linux and FreeBSD, test compiled on mingw/WIN32.

commit 042429d3454ca57564e932a727a27c7d6bfeb2d6 (master)
Author: David Sommerseth
Date:   Thu Feb 27 21:54:43 2020 +0100

     build: Remove --disable-server from ./configure

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20200227205443.27562-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19506.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


