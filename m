Date: Tue, 23 Jan 2024 19:52:55 +0100 (CET)
Message-Id: <202401231852.40NIqtOx064556@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240123104358.495517-1-frank@...2641...>
References: <20240123104358.495517-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ensure that all unit tests use
 unbuffered stdout and stderr
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

Tested on a local "make check" run and on GHA (another option might have
been to change our mock x_msg() to use stderr instead, but this way we
can also see "if anything else" wants to say something on stdout).

Your patch has been applied to the master branch.

commit 7869617a0f85089fb5e6fbe2db6f03542a8f33f4
Author: Arne Schwabe
Date:   Tue Jan 23 11:43:58 2024 +0100

     Ensure that all unit tests use unbuffered stdout and stderr

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240123104358.495517-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28122.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


