Date: Wed, 20 Aug 2025 23:12:55 +0200 (CEST)
Message-Id: <202508202112.57KLCtdB013204@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250820175459.11227-1-gert@...1296...>
References: <20250820175459.11227-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove use of 'dh dh2048.pem'
 from sample configs, remove 'dh2048.pem' file
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Tested on FreeBSD 15 with OpenSSL 3.5.1, and on all the buildbots + GHA
(various versions of OpenSSL 1.x and 3.x, plus mbedTLS 2.x and 3.x).

Patch has been applied to the master and release/2.6 branch (cleanup).

commit 2d73540316af3986bcb3e162040b5aaef74b1845 (master)
commit 8af210e49ae6245d41435556d6a448c1be8abd95 (release/2.6)
Author: Gert Doering
Date:   Wed Aug 20 19:54:53 2025 +0200

     Remove use of 'dh dh2048.pem' from sample configs, remove 'dh2048.pem' file

     Signed-off-by: Gert Doering <gert@...1296...>
     Message-Id: <20250820175459.11227-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32632.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


